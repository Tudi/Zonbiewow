/*
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "PacketLog.h"
#include "Config.h"
#include "IpAddress.h"
#include "Timer.h"
#include "WorldPacket.h"

#pragma pack(push, 1)

// Packet logging structures in PKT 3.1 format
struct LogHeader
{
    char Signature[3];
    uint16 FormatVersion;
    uint8 SnifferId;
    uint32 Build;
    char Locale[4];
    uint8 SessionKey[40];
    uint32 SniffStartUnixtime;
    uint32 SniffStartTicks;
    uint32 OptionalDataSize;
};

struct PacketHeader
{
    // used to uniquely identify a connection
    struct OptionalData
    {
        uint8 SocketIPBytes[16];
        uint32 SocketPort;
    };

    uint32 Direction;
    uint32 ConnectionId;
    uint32 ArrivalTicks;
    uint32 OptionalDataSize;
    uint32 Length;
    OptionalData OptionalData;
    uint32 Opcode;
};

#pragma pack(pop)

PacketLog::PacketLog() : _file(nullptr)
{
    std::call_once(_initializeFlag, &PacketLog::Initialize, this);
}

PacketLog::~PacketLog()
{
    if (_file)
        fclose(_file);

    _file = nullptr;
}

PacketLog* PacketLog::instance()
{
    static PacketLog instance;
    return &instance;
}

void PacketLog::Initialize()
{
    std::string logsDir = sConfigMgr->GetStringDefault("LogsDir", "");

    if (!logsDir.empty())
        if ((logsDir.at(logsDir.length() - 1) != '/') && (logsDir.at(logsDir.length() - 1) != '\\'))
            logsDir.push_back('/');

    std::string logname = sConfigMgr->GetStringDefault("PacketLogFile", "");
    if (!logname.empty())
    {
        _file = fopen((logsDir + logname).c_str(), "wb");

        LogHeader header;
        header.Signature[0] = 'P'; header.Signature[1] = 'K'; header.Signature[2] = 'T';
        header.FormatVersion = 0x0301;
        header.SnifferId = 'T';
        header.Build = 12340;
        header.Locale[0] = 'e'; header.Locale[1] = 'n'; header.Locale[2] = 'U'; header.Locale[3] = 'S';
        std::memset(header.SessionKey, 0, sizeof(header.SessionKey));
        header.SniffStartUnixtime = time(nullptr);
        header.SniffStartTicks = getMSTime();
        header.OptionalDataSize = 0;

        if (CanLogPacket())
            fwrite(&header, sizeof(header), 1, _file);
    }
}

void LogPacket2(uint32 len, uint16 opcode, const uint8* data, uint8 direction);
void PacketLog::LogPacket(WorldPacket const& packet, Direction direction, boost::asio::ip::address const& addr, uint16 port)
{
    std::lock_guard<std::mutex> lock(_logPacketLock);

    PacketHeader header;
    header.Direction = direction == CLIENT_TO_SERVER ? 0x47534d43 : 0x47534d53;
    header.ConnectionId = 0;
    header.ArrivalTicks = getMSTime();

    header.OptionalDataSize = sizeof(header.OptionalData);
    memset(header.OptionalData.SocketIPBytes, 0, sizeof(header.OptionalData.SocketIPBytes));
    if (addr.is_v4())
    {
        auto bytes = addr.to_v4().to_bytes();
        memcpy(header.OptionalData.SocketIPBytes, bytes.data(), bytes.size());
    }
    else if (addr.is_v6())
    {
        auto bytes = addr.to_v6().to_bytes();
        memcpy(header.OptionalData.SocketIPBytes, bytes.data(), bytes.size());
    }

    header.OptionalData.SocketPort = port;
    header.Length = packet.size() + sizeof(header.Opcode);
    header.Opcode = packet.GetOpcode();

    fwrite(&header, sizeof(header), 1, _file);
    if (!packet.empty())
        fwrite(packet.contents(), 1, packet.size(), _file);

    fflush(_file);

    if (!packet.empty())
        LogPacket2(packet.size(), packet.GetOpcode(), packet.contents(), direction);
    else
        LogPacket2(packet.size(), packet.GetOpcode(), NULL, direction);
}

void LogPacket2(uint32 len, uint16 opcode, const uint8* data, uint8 direction)
{
        unsigned int line = 1;
        unsigned int countpos = 0;
        uint16 lenght = len;    
        unsigned int count = 0;

        static FILE *m_file = fopen("./Logs/packets.log", "wt");
        if (m_file == NULL)
            return;

        fprintf(m_file, "{%s} Packet: (0x%04X) %s PacketSize = %u stamp = %u\n", (direction ? "SERVER" : "CLIENT"), opcode, GetOpcodeNameForLogging((Opcodes)(opcode)).c_str(), lenght, getMSTime());
        fprintf(m_file, "|------------------------------------------------|----------------|\n");
        fprintf(m_file, "|00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F |0123456789ABCDEF|\n");
        fprintf(m_file, "|------------------------------------------------|----------------|\n");

        if (lenght > 0)
        {
            fprintf(m_file, "|");
            for (count = 0; count < lenght; count++)
            {
                if (countpos == 16)
                {
                    countpos = 0;

                    fprintf(m_file, "|");

                    for (unsigned int a = count - 16; a < count; a++)
                    {
                        if ((data[a] < 32) || (data[a] > 126))
                            fprintf(m_file, ".");
                        else
                            fprintf(m_file, "%c", data[a]);
                    }

                    fprintf(m_file, "|\n");

                    line++;
                    fprintf(m_file, "|");
                }

                fprintf(m_file, "%02X ", data[count]);

                //FIX TO PARSE PACKETS WITH LENGHT < OR = TO 16 BYTES.
                if (count + 1 == lenght && lenght <= 16)
                {
                    for (unsigned int b = countpos + 1; b < 16; b++)
                        fprintf(m_file, "   ");

                    fprintf(m_file, "|");

                    for (unsigned int a = 0; a < lenght; a++)
                    {
                        if ((data[a] < 32) || (data[a] > 126))
                            fprintf(m_file, ".");
                        else
                            fprintf(m_file, "%c", data[a]);
                    }

                    for (unsigned int c = count; c < 15; c++)
                        fprintf(m_file, " ");

                    fprintf(m_file, "|\n");
                }

                //FIX TO PARSE THE LAST LINE OF THE PACKETS WHEN THE LENGHT IS > 16 AND ITS IN THE LAST LINE.
                if (count + 1 == lenght && lenght > 16)
                {
                    for (unsigned int b = countpos + 1; b < 16; b++)
                        fprintf(m_file, "   ");

                    fprintf(m_file, "|");

                    unsigned short print = 0;

                    for (unsigned int a = line * 16 - 16; a < lenght; a++)
                    {
                        if ((data[a] < 32) || (data[a] > 126))
                            fprintf(m_file, ".");
                        else
                            fprintf(m_file, "%c", data[a]);

                        print++;
                    }

                    for (unsigned int c = print; c < 16; c++)
                        fprintf(m_file, " ");

                    fprintf(m_file, "|\n");
                }

                countpos++;
            }
        }
        fprintf(m_file, "-------------------------------------------------------------------\n\n");
        fflush(m_file);
}
