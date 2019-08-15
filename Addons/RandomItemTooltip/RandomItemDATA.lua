RANDOM_ITEM_IRS  = {}	-- item random stat format string DB
RANDOM_ITEM_IRSC = {}	-- item random stat color
RANDOM_ITEM_IRNRL  = {} -- max value a stat can roll at 100% diff
local IRS = RANDOM_ITEM_IRS
local IRSC = RANDOM_ITEM_IRSC
local IRNRL = RANDOM_ITEM_IRNRL 
IRT = {}

IRS[1]="%d Strength"
IRS[2]="%d Agility"
IRS[3]="%d Stamina"
IRS[4]="%d Intelect"
IRS[5]="%d Spirit"
IRS[6]="%d Health"
IRS[7]="%d Mana"
IRS[8]="%d Rage"
IRS[9]="%d Focus"
IRS[10]="%d Energy"
IRS[11]="%d Rune"
IRS[12]="%d Runic Power"
IRS[13]="%d Armor"
IRS[14]="%d Resistance Holy"
IRS[15]="%d Resistance Fire"
IRS[16]="%d Resistance Nature"
IRS[17]="%d Resistance Frost"
IRS[18]="%d Resistance Shadow"
IRS[19]="%d Resistance Arcane"
IRS[20]="%d Attack Power"
IRS[21]="%d Ranged Attack Power"
IRS[22]="%d Damage Mainhand"
IRS[23]="%d Damage Offhand"
IRS[24]="%d Damage Ranged"
IRS[25]="%d Dodge Rating"
IRS[26]="%d Parry Rating"
IRS[27]="%d Block Rating"
IRS[28]="%d Block"
IRS[29]="%d Melee Hit Rating"
IRS[30]="%d Ranged Hit Rating"
IRS[31]="%d Spell Hit Rating"
IRS[32]="%d Melee Crit Rating"
IRS[33]="%d Ranged Crit Rating"
IRS[34]="%d Spell Crit Rating"
IRS[35]="%d Melee Hit Taken Rating"
IRS[36]="%d Ranged Hit Taken Rating"
IRS[37]="%d Spell Hit Taken Rating"
IRS[38]="%d Melee Crit Taken Rating"
IRS[39]="%d Ranged Crit Taken Rating"
IRS[40]="%d Spell Crit Taken Rating"
IRS[41]="%d Melee Haste Rating"
IRS[42]="%d Ranged Haste Rating"
IRS[43]="%d Spell Haste Rating"
IRS[44]="%d Expertise Rating"
IRS[45]="%d Armor Penetration Rating"
IRS[46]="%d Hit Rating"
IRS[47]="%d Crit Rating"
IRS[48]="%d Hit Taken Rating"
IRS[49]="%d Crit Taken Rating"
IRS[50]="%d Resiliance Rating"
IRS[51]="%d Haste Rating"
IRS[52]="%d Mana regen"
IRS[53]="%d Spell Power"
IRS[54]="%d Health Regen"
IRS[55]="%d Spell Penetration"
IRS[56]="%d Magic Find"
IRS[57]="%d Magic Find Power Rating"
IRS[58]="%.02f%% Run speed"
IRS[59]="%.02f%% Mounted speed"
IRS[60]="%d Physical Dmg"
IRS[61]="%d Holy Dmg"
IRS[62]="%d Fire Dmg"
IRS[63]="%d Nature Dmg"
IRS[64]="%d Frost Dmg"
IRS[65]="%d Shadow Dmg"
IRS[66]="%d Arcane Dmg"
IRS[67]="%d Spell Healing taken"
IRS[68]="%.02f%% Damage done target health based"
IRS[69]="%.02f%% Damage done target health missing"
IRS[70]="%.02f%% Heal target health based"
IRS[71]="%.02f%% Heal target missing health based"
IRS[72]="%d seconds to spell duration"
IRS[73]="%.02f%% longer spell duration"
IRS[74]="%d spell damage"
IRS[75]="%.02f%% spell damage"
IRS[76]="%d spell DOT damage"
IRS[77]="%.02f%% spell DOT damage"
IRS[78]="%d spell crit dmg"
IRS[79]="%.02f%% spell crit dmg"
IRS[80]="%.02f%% Threat"
IRS[81]="%.02f%% equip item dropchance"
IRS[82]="%.02f%% melee crit dmg"
IRS[83]="%.02f%% ranged crit dmg"
IRS[84]="%.02f%% Threat increase"
IRS[85]="%d continuous health regen"
IRS[86]="%.02f%% continuous health regen"
IRS[87]="%.02f%% continuous missing health regen"
IRS[88]="%.02f%% continuous current health regen"
IRS[89]="%.02f%% continuous current power regen"
IRS[90]="%d target power burn"
IRS[91]="%.02f%% target power burn"
IRS[92]="%d spell target"
IRS[93]="Gain Dual Wield"
IRS[94]="Gain Titan's Grip"
IRS[95]="Chance for knockdown on dmg"
IRS[96]="%d%% Critical heal amount"
IRS[97]="%d%% Hit chance"
IRS[98]="%d%% Spell Hit chance"
IRS[99]="%.02f%% Damage Taken from mana shield"
IRS[100]="%.02f%% Damage taken from mana"
IRS[101]="Gain Water Walk"
IRS[102]="Gain Feather Fall"
IRS[103]="Gain Hover"
IRS[104]="%.02f%% Spell Healing Taken"
IRS[105]="%.02f Spell Healing Done"
IRS[106]="%.02f%% Spell Healing Done"
IRS[107]="%d%% Magic Find Out Of Instance"
IRS[108]="%d%% Magic Find Strength Rating Out Of Instance"
IRS[109]="%d Damage Done To Health"
IRS[110]="%.02f%% Damage Done To Health"
IRS[111]="%d Mana To Damage"
IRS[112]="PCT Power missing To %.02f%% Damage"
IRS[113]="%d Damage taken To Mana"
IRS[114]="%.02f%% Damage taken To Mana"
IRS[115]="Chance To Cloack on Deadly Blow"
IRS[116]="%.02f%% Extra Gold"
IRS[117]="Chance To Ice Block on Deadly Blow"
IRS[118]="Chance To Divine Shield on Deadly Blow"
IRS[119]="%.02f%% to Min Max Damage"
IRS[120]="%.02f%% Cast speed"
IRS[121]="Target Explodes On Kill"
IRS[122]="%.02f%% damage reflected as Chain Lightning 1 On Struck"
IRS[123]="%d Damage reduction Based On Attacker Count"
IRS[124]="%d Damage Taken Converted to Damage"
IRS[125]="%.02f%% Damage Taken Converted to Damage"
IRS[126]="%.02f%% Strength"
IRS[127]="%.02f%% Agility"
IRS[128]="%.02f%% Stamina"
IRS[129]="%.02f%% Intelect"
IRS[130]="%.02f%% Spirit"
IRS[131]="%.02f%% Stats"
IRS[132]="-%d%% Casttime Pushback"
IRS[133]="-%d%% Global Cooldowns"
IRS[134]="%d Damage taken reduction based on raid size"
IRS[135]="%.02f%% Damage taken reduction based on raid size"
IRS[136]="%d Damage done based on raid size"
IRS[137]="%.02f%% Damage done based on raid size"
IRS[138]="%d Damage taken as 10 silver"
IRS[139]="%d Talent points"
IRS[140]="%d Damage taken Shared With Nearby Tanks"
IRS[141]="%.02f%% Damage taken Shared With Nearby Tanks"
IRS[142]="%d Damage taken Shared With Nearby Casters"
IRS[143]="%.02f%% Damage taken Shared With Nearby Casters"
IRS[144]="Chance to reduce cooldown of previous spell"
IRS[145]="%d Extra dmg while below 20%% HP"
IRS[146]="%.02f%% Extra dmg while below 20%% HP"
IRS[147]="%d%% Evade while below 20%% HP"
IRS[148]="%d%% Absorb while below 20%% HP"
IRS[149]="%d%% Stat Roll Chance"
IRS[150]="Damage Taken Can't exceed %d%% Max HP"
IRS[151]="Gain Ice Armor"
IRS[152]="Gain Demon Armor"
IRS[153]="Gain Fel Armor"
IRS[154]="Gain Metamorphosis"
IRS[155]="Gain Reincarnation"
IRS[156]="Chance to loose debuff on direct heal"
IRS[157]="Chance To Dispersion on Deadly Blow"
IRS[158]="Chance To Disengage on Damage"
IRS[159]="Chance to stormstrike on direct heal"
IRS[160]="Chance to clear potion cooldown on damage taken"
IRS[161]="%.02f%% Of Overheal is added to your next damage"
IRS[162]="Party mimics some of self cast auras"
IRS[163]="%.02f%% Of Current Health Is Added To Heals"
IRS[164]="Chance to cast same spell for free"
IRS[165]="%d%% chance to favor utility stats roll"
IRS[166]="%d%% chance to favor attack stats roll"
IRS[167]="%d%% chance to favor defense stats roll"
IRS[168]="%.02f Damage done for each unqiue monsters killed"
IRS[169]="%.02f Heal for each unqiue monsters killed"
IRS[170]="%.02f Damage done for each unqiue item used"
IRS[171]="%.02f Heal for each unqiue item used"
IRS[172]="%.02f Damage done for each achievement earned"
IRS[173]="%.02f Heal for each achievement earned"
IRS[174]="%.02f Damage done for each quest finished"
IRS[175]="%.02f Heal for each quest finished"
IRS[176]="%.02f Damage done for honorable kill rating"
IRS[177]="%.02f Heal for honorable kill rating"
IRS[178]="%.02f%% Spell Cost Reduction"
IRS[179]="Leather proficiency"
IRS[180]="Mail proficiency"
IRS[181]="Plate Mail proficiency"
IRS[182]="One-Handed Axe proficiency"
IRS[183]="One-Handed Mace proficiency"
IRS[184]="One-Handed Swords proficiency"
IRS[185]="Polearms proficiency"
IRS[186]="Shield proficiency"
IRS[187]="Two-Handed Axes proficiency"
IRS[188]="Two-Handed Maces proficiency"
IRS[189]="Two-Handed Sword proficiency"
IRS[190]="Staves proficiency"
IRS[191]="Learn Frost Nova"
IRS[192]="Learn Summon Succubus"
IRS[193]="Learn Charge"
IRS[194]="Learn Inervate"
IRS[195]="Gain Mark of the Wild"
IRS[196]="Learn Nature's Grasp"
IRS[197]="Learn Rebirth"
IRS[198]="Learn Deterrence"
IRS[199]="Learn Rapid Fire"
IRS[200]="Learn Arcane Power"
IRS[201]="Learn Counter Spell"
IRS[202]="Learn Evocation"
IRS[203]="Learn Focus Magic"
IRS[204]="Learn Icy Veins"
IRS[205]="Learn Divine Storm"
IRS[206]="Learn Seal of Light"
IRS[207]="Learn Divine Hymn"
IRS[208]="Learn Hymn of Hope"
IRS[209]="Learn Inner Focus"
IRS[210]="Learn Mana Burn"
IRS[211]="Learn Last Stand"
IRS[212]="Learn BloodLust"
IRS[213]="Learn Shamanistic Rage"
IRS[214]="Learn Blade Flurry"
IRS[215]="Learn Cold Blood"
IRS[216]="Learn Fan of Knives"
IRS[217]="Learn Killing Spree"
IRS[218]="Learn Hysteria"
IRS[219]="Learn Windfury Weapon"
IRS[220]="%d%% Pet Threat"
IRS[221]="Pet gains Immolation Aura"
IRS[222]="%d Dmg for daily login streak"
IRS[223]="%d Heal for daily login streak"
IRS[224]="Chance to auto charge on target swap"
IRS[225]="%d%% Strength to spell damage"
IRS[226]="%d%% Agility to spell damage"
IRS[227]="%.02f%% Intelect to spell damage"
IRS[228]="%.02f%% Spirit to spell damage"
IRS[229]="%d%% Strength to Heal"
IRS[230]="%d%% Agility to Heal"
IRS[231]="%d%% Intelect to Heal"
IRS[232]="%d%% Spirit to Heal"
IRS[233]="%d%% of Heals received recharges Absorb auras"
IRS[234]="Chance to discover transmog on kill"
IRS[235]="Your footsteps burn"
IRS[236]="Cast previous single target spell when moving"
IRS[237]="%.02f%% Armor to Attack Power"
IRS[238]="%.02f%% Strength to Attack Power"
IRS[239]="%.02f%% Agility to Attack Power"
IRS[240]="%.02f%% Intelect to Attack Power"
IRS[241]="%.02f%% Spirit to Attack Power"
IRS[242]="%.02f%% Strength to Ranged Attack Power"
IRS[243]="%.02f%% Agility to Ranged Attack Power"
IRS[244]="%.02f%% Intelect to Ranged Attack Power"
IRS[245]="%.02f%% Spirit to Ranged Attack Power"
IRS[246]="Allow casting while moving"
IRS[247]="Can cast instant spells while casting"
IRS[248]="Spells no longer need to face targets"
IRS[249]="%d%% Negative Melee haste to %% Damage"
IRS[250]="%d%% Negative Ranged haste to %% Damage"
IRS[251]="%d%% Negative Spell haste to %% Damage"
IRS[252]="%d%% Negative Spell haste to %% Heal"
IRS[253]="You deal Fire damage"
IRS[254]="You deal Nature damage"
IRS[255]="You deal Frost damage"
IRS[256]="You deal Shadow damage"
IRS[257]="You deal Arcane damage"
IRS[258]="Chance to Slam Dunk at jump( health based )"
IRS[259]="Electrocute while casting(based on highest stat)"
IRS[260]="Diablo tranformation"
IRS[261]="%d%% Extra heal the closer you are"
IRS[262]="Chance to gain BloodLust on damage taken"
IRS[263]="Moving charges an explosion"
IRS[264]="Fist Weapon proficiency"
IRS[265]="%d Spell Range"
IRS[266]="Some Auras can stack to 2"
IRS[267]="%.02f%% Armor to Holy Resistance"
IRS[268]="%.02f%% Armor to Fire Resistance"
IRS[269]="%.02f%% Armor to Nature Resistance"
IRS[270]="%.02f%% Armor to Frost Resistance"
IRS[271]="%.02f%% Armor to Shadow Resistance"
IRS[272]="%.02f%% Armor to Arcane Resistance"
IRS[273]="%.02f%% Heal for each nearby player"
IRS[274]="%.02f%% Dmg for each nearby player"
IRS[275]="%d%% More Dust gained"
IRS[276]="Learn Blink"
IRS[277]="Learn Righteous Fury"
IRS[278]="%d Dmg for Killstreak Rating"
IRS[279]="%d Heal for consecutive low(50%%) target health heals"
IRS[280]="You take similar damage"
IRS[281]="Non lethal damage taken is split over %d seconds"
IRS[282]="%d extra Blood Rune regen speed"
IRS[283]="%d extra Unholy Rune regen speed"
IRS[284]="%d extra Frost Rune regen speed"
IRS[285]="%d extra Death Rune regen speed"
IRS[286]="%d%% Rune decrease reduction"
IRS[287]="%d%% extra Energy regen speed"
IRS[288]="%d extra Focus regen at tick"
IRS[289]="%d Rage regen at tick"
IRS[290]="Gain Sprint after a kill"
IRS[291]="%d extra direct damage done while behind target"
IRS[292]="%d damage taken reduction while facing attacker"
IRS[293]="Direct Heals restore %d%% of last damage taken"
IRS[294]="%.02f%% XP gained"
IRS[295]="%.02f%% single target damage converted to AOE damage"
IRS[296]="%.02f%% damage as Chain Lightning 1 on direct hit"
IRS[297]="%.02f%% damage as Chain Lightning 2 on direct hit"
IRS[298]="%.02f%% damage as Chain Lightning 3 on direct hit"
IRS[299]="%.02f%% damage reflected as Chain Lightning 2 On Struck"
IRS[300]="%.02f%% damage reflected as Chain Lightning 3 On Struck"
IRS[301]="Learn Death Grip"
IRS[302]="%d Health converted to damage"
IRS[303]="%.02f%% Damage Done"
IRS[304]="%d Damage Done"
IRSC[1]={};IRSC[1][0]=1.00;IRSC[1][1]=0.25;IRSC[1][2]=0.25;
IRSC[2]={};IRSC[2][0]=1.00;IRSC[2][1]=0.25;IRSC[2][2]=0.25;
IRSC[3]={};IRSC[3][0]=0.25;IRSC[3][1]=1.00;IRSC[3][2]=0.25;
IRSC[4]={};IRSC[4][0]=1.00;IRSC[4][1]=0.25;IRSC[4][2]=0.25;
IRSC[5]={};IRSC[5][0]=1.00;IRSC[5][1]=0.25;IRSC[5][2]=0.25;
IRSC[6]={};IRSC[6][0]=1.00;IRSC[6][1]=0.65;IRSC[6][2]=0.00;
IRSC[7]={};IRSC[7][0]=1.00;IRSC[7][1]=0.65;IRSC[7][2]=0.00;
IRSC[8]={};IRSC[8][0]=1.00;IRSC[8][1]=0.25;IRSC[8][2]=0.25;
IRSC[9]={};IRSC[9][0]=1.00;IRSC[9][1]=0.25;IRSC[9][2]=0.25;
IRSC[10]={};IRSC[10][0]=1.00;IRSC[10][1]=0.25;IRSC[10][2]=0.25;
IRSC[11]={};IRSC[11][0]=1.00;IRSC[11][1]=0.25;IRSC[11][2]=0.25;
IRSC[12]={};IRSC[12][0]=1.00;IRSC[12][1]=0.25;IRSC[12][2]=0.25;
IRSC[13]={};IRSC[13][0]=0.25;IRSC[13][1]=1.00;IRSC[13][2]=0.25;
IRSC[14]={};IRSC[14][0]=0.25;IRSC[14][1]=1.00;IRSC[14][2]=0.25;
IRSC[15]={};IRSC[15][0]=0.25;IRSC[15][1]=1.00;IRSC[15][2]=0.25;
IRSC[16]={};IRSC[16][0]=0.25;IRSC[16][1]=1.00;IRSC[16][2]=0.25;
IRSC[17]={};IRSC[17][0]=0.25;IRSC[17][1]=1.00;IRSC[17][2]=0.25;
IRSC[18]={};IRSC[18][0]=0.25;IRSC[18][1]=1.00;IRSC[18][2]=0.25;
IRSC[19]={};IRSC[19][0]=0.25;IRSC[19][1]=1.00;IRSC[19][2]=0.25;
IRSC[20]={};IRSC[20][0]=1.00;IRSC[20][1]=0.25;IRSC[20][2]=0.25;
IRSC[21]={};IRSC[21][0]=1.00;IRSC[21][1]=0.25;IRSC[21][2]=0.25;
IRSC[22]={};IRSC[22][0]=1.00;IRSC[22][1]=0.25;IRSC[22][2]=0.25;
IRSC[23]={};IRSC[23][0]=1.00;IRSC[23][1]=0.25;IRSC[23][2]=0.25;
IRSC[24]={};IRSC[24][0]=1.00;IRSC[24][1]=0.25;IRSC[24][2]=0.25;
IRSC[25]={};IRSC[25][0]=0.25;IRSC[25][1]=1.00;IRSC[25][2]=0.25;
IRSC[26]={};IRSC[26][0]=0.25;IRSC[26][1]=1.00;IRSC[26][2]=0.25;
IRSC[27]={};IRSC[27][0]=0.25;IRSC[27][1]=1.00;IRSC[27][2]=0.25;
IRSC[28]={};IRSC[28][0]=0.25;IRSC[28][1]=1.00;IRSC[28][2]=0.25;
IRSC[29]={};IRSC[29][0]=1.00;IRSC[29][1]=0.25;IRSC[29][2]=0.25;
IRSC[30]={};IRSC[30][0]=1.00;IRSC[30][1]=0.25;IRSC[30][2]=0.25;
IRSC[31]={};IRSC[31][0]=1.00;IRSC[31][1]=0.25;IRSC[31][2]=0.25;
IRSC[32]={};IRSC[32][0]=1.00;IRSC[32][1]=0.25;IRSC[32][2]=0.25;
IRSC[33]={};IRSC[33][0]=1.00;IRSC[33][1]=0.25;IRSC[33][2]=0.25;
IRSC[34]={};IRSC[34][0]=1.00;IRSC[34][1]=0.25;IRSC[34][2]=0.25;
IRSC[35]={};IRSC[35][0]=0.25;IRSC[35][1]=1.00;IRSC[35][2]=0.25;
IRSC[36]={};IRSC[36][0]=0.25;IRSC[36][1]=1.00;IRSC[36][2]=0.25;
IRSC[37]={};IRSC[37][0]=0.25;IRSC[37][1]=1.00;IRSC[37][2]=0.25;
IRSC[38]={};IRSC[38][0]=0.25;IRSC[38][1]=1.00;IRSC[38][2]=0.25;
IRSC[39]={};IRSC[39][0]=0.25;IRSC[39][1]=1.00;IRSC[39][2]=0.25;
IRSC[40]={};IRSC[40][0]=0.25;IRSC[40][1]=1.00;IRSC[40][2]=0.25;
IRSC[41]={};IRSC[41][0]=1.00;IRSC[41][1]=0.25;IRSC[41][2]=0.25;
IRSC[42]={};IRSC[42][0]=1.00;IRSC[42][1]=0.25;IRSC[42][2]=0.25;
IRSC[43]={};IRSC[43][0]=1.00;IRSC[43][1]=0.65;IRSC[43][2]=0.00;
IRSC[44]={};IRSC[44][0]=1.00;IRSC[44][1]=0.25;IRSC[44][2]=0.25;
IRSC[45]={};IRSC[45][0]=1.00;IRSC[45][1]=0.25;IRSC[45][2]=0.25;
IRSC[46]={};IRSC[46][0]=1.00;IRSC[46][1]=0.25;IRSC[46][2]=0.25;
IRSC[47]={};IRSC[47][0]=1.00;IRSC[47][1]=0.25;IRSC[47][2]=0.25;
IRSC[48]={};IRSC[48][0]=0.25;IRSC[48][1]=1.00;IRSC[48][2]=0.25;
IRSC[49]={};IRSC[49][0]=0.25;IRSC[49][1]=1.00;IRSC[49][2]=0.25;
IRSC[50]={};IRSC[50][0]=0.25;IRSC[50][1]=1.00;IRSC[50][2]=0.25;
IRSC[51]={};IRSC[51][0]=0.25;IRSC[51][1]=1.00;IRSC[51][2]=0.25;
IRSC[52]={};IRSC[52][0]=0.25;IRSC[52][1]=1.00;IRSC[52][2]=0.25;
IRSC[53]={};IRSC[53][0]=1.00;IRSC[53][1]=0.65;IRSC[53][2]=0.00;
IRSC[54]={};IRSC[54][0]=0.25;IRSC[54][1]=1.00;IRSC[54][2]=0.25;
IRSC[55]={};IRSC[55][0]=1.00;IRSC[55][1]=0.25;IRSC[55][2]=0.25;
IRSC[56]={};IRSC[56][0]=0.50;IRSC[56][1]=0.50;IRSC[56][2]=1.00;
IRSC[57]={};IRSC[57][0]=0.50;IRSC[57][1]=0.50;IRSC[57][2]=1.00;
IRSC[58]={};IRSC[58][0]=1.00;IRSC[58][1]=0.65;IRSC[58][2]=0.00;
IRSC[59]={};IRSC[59][0]=1.00;IRSC[59][1]=0.65;IRSC[59][2]=0.00;
IRSC[60]={};IRSC[60][0]=1.00;IRSC[60][1]=0.25;IRSC[60][2]=0.25;
IRSC[61]={};IRSC[61][0]=1.00;IRSC[61][1]=0.25;IRSC[61][2]=0.25;
IRSC[62]={};IRSC[62][0]=1.00;IRSC[62][1]=0.25;IRSC[62][2]=0.25;
IRSC[63]={};IRSC[63][0]=1.00;IRSC[63][1]=0.25;IRSC[63][2]=0.25;
IRSC[64]={};IRSC[64][0]=1.00;IRSC[64][1]=0.25;IRSC[64][2]=0.25;
IRSC[65]={};IRSC[65][0]=1.00;IRSC[65][1]=0.25;IRSC[65][2]=0.25;
IRSC[66]={};IRSC[66][0]=1.00;IRSC[66][1]=0.25;IRSC[66][2]=0.25;
IRSC[67]={};IRSC[67][0]=0.25;IRSC[67][1]=1.00;IRSC[67][2]=0.25;
IRSC[68]={};IRSC[68][0]=1.00;IRSC[68][1]=0.25;IRSC[68][2]=0.25;
IRSC[69]={};IRSC[69][0]=1.00;IRSC[69][1]=0.25;IRSC[69][2]=0.25;
IRSC[70]={};IRSC[70][0]=0.25;IRSC[70][1]=1.00;IRSC[70][2]=0.25;
IRSC[71]={};IRSC[71][0]=0.25;IRSC[71][1]=1.00;IRSC[71][2]=0.25;
IRSC[72]={};IRSC[72][0]=1.00;IRSC[72][1]=0.65;IRSC[72][2]=0.00;
IRSC[73]={};IRSC[73][0]=1.00;IRSC[73][1]=0.65;IRSC[73][2]=0.00;
IRSC[74]={};IRSC[74][0]=1.00;IRSC[74][1]=0.25;IRSC[74][2]=0.25;
IRSC[75]={};IRSC[75][0]=1.00;IRSC[75][1]=0.25;IRSC[75][2]=0.25;
IRSC[76]={};IRSC[76][0]=1.00;IRSC[76][1]=0.25;IRSC[76][2]=0.25;
IRSC[77]={};IRSC[77][0]=1.00;IRSC[77][1]=0.25;IRSC[77][2]=0.25;
IRSC[78]={};IRSC[78][0]=1.00;IRSC[78][1]=0.25;IRSC[78][2]=0.25;
IRSC[79]={};IRSC[79][0]=1.00;IRSC[79][1]=0.25;IRSC[79][2]=0.25;
IRSC[80]={};IRSC[80][0]=1.00;IRSC[80][1]=0.65;IRSC[80][2]=0.00;
IRSC[81]={};IRSC[81][0]=0.50;IRSC[81][1]=0.50;IRSC[81][2]=1.00;
IRSC[82]={};IRSC[82][0]=1.00;IRSC[82][1]=0.25;IRSC[82][2]=0.25;
IRSC[83]={};IRSC[83][0]=1.00;IRSC[83][1]=0.25;IRSC[83][2]=0.25;
IRSC[84]={};IRSC[84][0]=1.00;IRSC[84][1]=0.65;IRSC[84][2]=0.00;
IRSC[85]={};IRSC[85][0]=0.25;IRSC[85][1]=1.00;IRSC[85][2]=0.25;
IRSC[86]={};IRSC[86][0]=0.25;IRSC[86][1]=1.00;IRSC[86][2]=0.25;
IRSC[87]={};IRSC[87][0]=0.25;IRSC[87][1]=1.00;IRSC[87][2]=0.25;
IRSC[88]={};IRSC[88][0]=0.25;IRSC[88][1]=1.00;IRSC[88][2]=0.25;
IRSC[89]={};IRSC[89][0]=1.00;IRSC[89][1]=0.65;IRSC[89][2]=0.00;
IRSC[90]={};IRSC[90][0]=1.00;IRSC[90][1]=0.25;IRSC[90][2]=0.25;
IRSC[91]={};IRSC[91][0]=1.00;IRSC[91][1]=0.25;IRSC[91][2]=0.25;
IRSC[92]={};IRSC[92][0]=1.00;IRSC[92][1]=0.25;IRSC[92][2]=0.25;
IRSC[93]={};IRSC[93][0]=1.00;IRSC[93][1]=0.25;IRSC[93][2]=0.25;
IRSC[94]={};IRSC[94][0]=1.00;IRSC[94][1]=0.25;IRSC[94][2]=0.25;
IRSC[95]={};IRSC[95][0]=1.00;IRSC[95][1]=0.25;IRSC[95][2]=0.25;
IRSC[96]={};IRSC[96][0]=0.25;IRSC[96][1]=1.00;IRSC[96][2]=0.25;
IRSC[97]={};IRSC[97][0]=1.00;IRSC[97][1]=0.25;IRSC[97][2]=0.25;
IRSC[98]={};IRSC[98][0]=1.00;IRSC[98][1]=0.25;IRSC[98][2]=0.25;
IRSC[99]={};IRSC[99][0]=0.25;IRSC[99][1]=1.00;IRSC[99][2]=0.25;
IRSC[100]={};IRSC[100][0]=0.25;IRSC[100][1]=1.00;IRSC[100][2]=0.25;
IRSC[101]={};IRSC[101][0]=0.50;IRSC[101][1]=0.50;IRSC[101][2]=1.00;
IRSC[102]={};IRSC[102][0]=0.50;IRSC[102][1]=0.50;IRSC[102][2]=1.00;
IRSC[103]={};IRSC[103][0]=0.50;IRSC[103][1]=0.50;IRSC[103][2]=1.00;
IRSC[104]={};IRSC[104][0]=0.25;IRSC[104][1]=1.00;IRSC[104][2]=0.25;
IRSC[105]={};IRSC[105][0]=0.25;IRSC[105][1]=1.00;IRSC[105][2]=0.25;
IRSC[106]={};IRSC[106][0]=0.25;IRSC[106][1]=1.00;IRSC[106][2]=0.25;
IRSC[107]={};IRSC[107][0]=0.50;IRSC[107][1]=0.50;IRSC[107][2]=1.00;
IRSC[108]={};IRSC[108][0]=0.50;IRSC[108][1]=0.50;IRSC[108][2]=1.00;
IRSC[109]={};IRSC[109][0]=0.25;IRSC[109][1]=1.00;IRSC[109][2]=0.25;
IRSC[110]={};IRSC[110][0]=0.25;IRSC[110][1]=1.00;IRSC[110][2]=0.25;
IRSC[111]={};IRSC[111][0]=1.00;IRSC[111][1]=0.25;IRSC[111][2]=0.25;
IRSC[112]={};IRSC[112][0]=1.00;IRSC[112][1]=0.25;IRSC[112][2]=0.25;
IRSC[113]={};IRSC[113][0]=1.00;IRSC[113][1]=0.25;IRSC[113][2]=0.25;
IRSC[114]={};IRSC[114][0]=1.00;IRSC[114][1]=0.25;IRSC[114][2]=0.25;
IRSC[115]={};IRSC[115][0]=0.25;IRSC[115][1]=1.00;IRSC[115][2]=0.25;
IRSC[116]={};IRSC[116][0]=0.50;IRSC[116][1]=0.50;IRSC[116][2]=1.00;
IRSC[117]={};IRSC[117][0]=0.50;IRSC[117][1]=0.50;IRSC[117][2]=1.00;
IRSC[118]={};IRSC[118][0]=0.50;IRSC[118][1]=0.50;IRSC[118][2]=1.00;
IRSC[119]={};IRSC[119][0]=1.00;IRSC[119][1]=0.25;IRSC[119][2]=0.25;
IRSC[120]={};IRSC[120][0]=1.00;IRSC[120][1]=0.65;IRSC[120][2]=0.00;
IRSC[121]={};IRSC[121][0]=1.00;IRSC[121][1]=0.25;IRSC[121][2]=0.25;
IRSC[122]={};IRSC[122][0]=1.00;IRSC[122][1]=0.25;IRSC[122][2]=0.25;
IRSC[123]={};IRSC[123][0]=0.25;IRSC[123][1]=1.00;IRSC[123][2]=0.25;
IRSC[124]={};IRSC[124][0]=1.00;IRSC[124][1]=0.25;IRSC[124][2]=0.25;
IRSC[125]={};IRSC[125][0]=1.00;IRSC[125][1]=0.25;IRSC[125][2]=0.25;
IRSC[126]={};IRSC[126][0]=1.00;IRSC[126][1]=0.65;IRSC[126][2]=0.00;
IRSC[127]={};IRSC[127][0]=1.00;IRSC[127][1]=0.65;IRSC[127][2]=0.00;
IRSC[128]={};IRSC[128][0]=0.25;IRSC[128][1]=1.00;IRSC[128][2]=0.25;
IRSC[129]={};IRSC[129][0]=1.00;IRSC[129][1]=0.65;IRSC[129][2]=0.00;
IRSC[130]={};IRSC[130][0]=1.00;IRSC[130][1]=0.65;IRSC[130][2]=0.00;
IRSC[131]={};IRSC[131][0]=1.00;IRSC[131][1]=0.65;IRSC[131][2]=0.00;
IRSC[132]={};IRSC[132][0]=1.00;IRSC[132][1]=0.65;IRSC[132][2]=0.00;
IRSC[133]={};IRSC[133][0]=1.00;IRSC[133][1]=0.65;IRSC[133][2]=0.00;
IRSC[134]={};IRSC[134][0]=0.25;IRSC[134][1]=1.00;IRSC[134][2]=0.25;
IRSC[135]={};IRSC[135][0]=0.25;IRSC[135][1]=1.00;IRSC[135][2]=0.25;
IRSC[136]={};IRSC[136][0]=0.25;IRSC[136][1]=1.00;IRSC[136][2]=0.25;
IRSC[137]={};IRSC[137][0]=0.25;IRSC[137][1]=1.00;IRSC[137][2]=0.25;
IRSC[138]={};IRSC[138][0]=0.25;IRSC[138][1]=1.00;IRSC[138][2]=0.25;
IRSC[139]={};IRSC[139][0]=0.25;IRSC[139][1]=1.00;IRSC[139][2]=0.25;
IRSC[140]={};IRSC[140][0]=0.25;IRSC[140][1]=1.00;IRSC[140][2]=0.25;
IRSC[141]={};IRSC[141][0]=0.25;IRSC[141][1]=1.00;IRSC[141][2]=0.25;
IRSC[142]={};IRSC[142][0]=0.25;IRSC[142][1]=1.00;IRSC[142][2]=0.25;
IRSC[143]={};IRSC[143][0]=0.25;IRSC[143][1]=1.00;IRSC[143][2]=0.25;
IRSC[144]={};IRSC[144][0]=0.25;IRSC[144][1]=1.00;IRSC[144][2]=0.25;
IRSC[145]={};IRSC[145][0]=1.00;IRSC[145][1]=0.25;IRSC[145][2]=0.25;
IRSC[146]={};IRSC[146][0]=1.00;IRSC[146][1]=0.25;IRSC[146][2]=0.25;
IRSC[147]={};IRSC[147][0]=0.25;IRSC[147][1]=1.00;IRSC[147][2]=0.25;
IRSC[148]={};IRSC[148][0]=0.25;IRSC[148][1]=1.00;IRSC[148][2]=0.25;
IRSC[149]={};IRSC[149][0]=0.50;IRSC[149][1]=0.50;IRSC[149][2]=1.00;
IRSC[150]={};IRSC[150][0]=0.25;IRSC[150][1]=1.00;IRSC[150][2]=0.25;
IRSC[151]={};IRSC[151][0]=0.50;IRSC[151][1]=0.50;IRSC[151][2]=1.00;
IRSC[152]={};IRSC[152][0]=0.50;IRSC[152][1]=0.50;IRSC[152][2]=1.00;
IRSC[153]={};IRSC[153][0]=0.50;IRSC[153][1]=0.50;IRSC[153][2]=1.00;
IRSC[154]={};IRSC[154][0]=0.50;IRSC[154][1]=0.50;IRSC[154][2]=1.00;
IRSC[155]={};IRSC[155][0]=0.50;IRSC[155][1]=0.50;IRSC[155][2]=1.00;
IRSC[156]={};IRSC[156][0]=0.50;IRSC[156][1]=0.50;IRSC[156][2]=1.00;
IRSC[157]={};IRSC[157][0]=0.25;IRSC[157][1]=1.00;IRSC[157][2]=0.25;
IRSC[158]={};IRSC[158][0]=0.50;IRSC[158][1]=0.50;IRSC[158][2]=1.00;
IRSC[159]={};IRSC[159][0]=0.50;IRSC[159][1]=0.50;IRSC[159][2]=1.00;
IRSC[160]={};IRSC[160][0]=0.50;IRSC[160][1]=0.50;IRSC[160][2]=1.00;
IRSC[161]={};IRSC[161][0]=1.00;IRSC[161][1]=0.25;IRSC[161][2]=0.25;
IRSC[162]={};IRSC[162][0]=0.50;IRSC[162][1]=0.50;IRSC[162][2]=1.00;
IRSC[163]={};IRSC[163][0]=0.50;IRSC[163][1]=0.50;IRSC[163][2]=1.00;
IRSC[164]={};IRSC[164][0]=0.50;IRSC[164][1]=0.50;IRSC[164][2]=1.00;
IRSC[165]={};IRSC[165][0]=0.50;IRSC[165][1]=0.50;IRSC[165][2]=1.00;
IRSC[166]={};IRSC[166][0]=0.50;IRSC[166][1]=0.50;IRSC[166][2]=1.00;
IRSC[167]={};IRSC[167][0]=0.50;IRSC[167][1]=0.50;IRSC[167][2]=1.00;
IRSC[168]={};IRSC[168][0]=1.00;IRSC[168][1]=0.25;IRSC[168][2]=0.25;
IRSC[169]={};IRSC[169][0]=0.25;IRSC[169][1]=1.00;IRSC[169][2]=0.25;
IRSC[170]={};IRSC[170][0]=1.00;IRSC[170][1]=0.25;IRSC[170][2]=0.25;
IRSC[171]={};IRSC[171][0]=0.25;IRSC[171][1]=1.00;IRSC[171][2]=0.25;
IRSC[172]={};IRSC[172][0]=1.00;IRSC[172][1]=0.25;IRSC[172][2]=0.25;
IRSC[173]={};IRSC[173][0]=0.25;IRSC[173][1]=1.00;IRSC[173][2]=0.25;
IRSC[174]={};IRSC[174][0]=1.00;IRSC[174][1]=0.25;IRSC[174][2]=0.25;
IRSC[175]={};IRSC[175][0]=0.25;IRSC[175][1]=1.00;IRSC[175][2]=0.25;
IRSC[176]={};IRSC[176][0]=1.00;IRSC[176][1]=0.25;IRSC[176][2]=0.25;
IRSC[177]={};IRSC[177][0]=0.25;IRSC[177][1]=1.00;IRSC[177][2]=0.25;
IRSC[178]={};IRSC[178][0]=1.00;IRSC[178][1]=0.65;IRSC[178][2]=0.00;
IRSC[179]={};IRSC[179][0]=1.00;IRSC[179][1]=0.65;IRSC[179][2]=0.00;
IRSC[180]={};IRSC[180][0]=1.00;IRSC[180][1]=0.65;IRSC[180][2]=0.00;
IRSC[181]={};IRSC[181][0]=1.00;IRSC[181][1]=0.65;IRSC[181][2]=0.00;
IRSC[182]={};IRSC[182][0]=1.00;IRSC[182][1]=0.25;IRSC[182][2]=0.25;
IRSC[183]={};IRSC[183][0]=1.00;IRSC[183][1]=0.25;IRSC[183][2]=0.25;
IRSC[184]={};IRSC[184][0]=1.00;IRSC[184][1]=0.25;IRSC[184][2]=0.25;
IRSC[185]={};IRSC[185][0]=1.00;IRSC[185][1]=0.25;IRSC[185][2]=0.25;
IRSC[186]={};IRSC[186][0]=0.25;IRSC[186][1]=1.00;IRSC[186][2]=0.25;
IRSC[187]={};IRSC[187][0]=1.00;IRSC[187][1]=0.25;IRSC[187][2]=0.25;
IRSC[188]={};IRSC[188][0]=1.00;IRSC[188][1]=0.25;IRSC[188][2]=0.25;
IRSC[189]={};IRSC[189][0]=1.00;IRSC[189][1]=0.25;IRSC[189][2]=0.25;
IRSC[190]={};IRSC[190][0]=1.00;IRSC[190][1]=0.25;IRSC[190][2]=0.25;
IRSC[191]={};IRSC[191][0]=0.50;IRSC[191][1]=0.50;IRSC[191][2]=1.00;
IRSC[192]={};IRSC[192][0]=0.50;IRSC[192][1]=0.50;IRSC[192][2]=1.00;
IRSC[193]={};IRSC[193][0]=0.50;IRSC[193][1]=0.50;IRSC[193][2]=1.00;
IRSC[194]={};IRSC[194][0]=0.50;IRSC[194][1]=0.50;IRSC[194][2]=1.00;
IRSC[195]={};IRSC[195][0]=0.25;IRSC[195][1]=1.00;IRSC[195][2]=0.25;
IRSC[196]={};IRSC[196][0]=0.50;IRSC[196][1]=0.50;IRSC[196][2]=1.00;
IRSC[197]={};IRSC[197][0]=0.50;IRSC[197][1]=0.50;IRSC[197][2]=1.00;
IRSC[198]={};IRSC[198][0]=0.50;IRSC[198][1]=0.50;IRSC[198][2]=1.00;
IRSC[199]={};IRSC[199][0]=1.00;IRSC[199][1]=0.25;IRSC[199][2]=0.25;
IRSC[200]={};IRSC[200][0]=1.00;IRSC[200][1]=0.25;IRSC[200][2]=0.25;
IRSC[201]={};IRSC[201][0]=0.50;IRSC[201][1]=0.50;IRSC[201][2]=1.00;
IRSC[202]={};IRSC[202][0]=0.50;IRSC[202][1]=0.50;IRSC[202][2]=1.00;
IRSC[203]={};IRSC[203][0]=0.50;IRSC[203][1]=0.50;IRSC[203][2]=1.00;
IRSC[204]={};IRSC[204][0]=0.50;IRSC[204][1]=0.50;IRSC[204][2]=1.00;
IRSC[205]={};IRSC[205][0]=0.50;IRSC[205][1]=0.50;IRSC[205][2]=1.00;
IRSC[206]={};IRSC[206][0]=0.50;IRSC[206][1]=0.50;IRSC[206][2]=1.00;
IRSC[207]={};IRSC[207][0]=0.50;IRSC[207][1]=0.50;IRSC[207][2]=1.00;
IRSC[208]={};IRSC[208][0]=0.50;IRSC[208][1]=0.50;IRSC[208][2]=1.00;
IRSC[209]={};IRSC[209][0]=0.50;IRSC[209][1]=0.50;IRSC[209][2]=1.00;
IRSC[210]={};IRSC[210][0]=1.00;IRSC[210][1]=0.25;IRSC[210][2]=0.25;
IRSC[211]={};IRSC[211][0]=0.50;IRSC[211][1]=0.50;IRSC[211][2]=1.00;
IRSC[212]={};IRSC[212][0]=1.00;IRSC[212][1]=0.25;IRSC[212][2]=0.25;
IRSC[213]={};IRSC[213][0]=1.00;IRSC[213][1]=0.25;IRSC[213][2]=0.25;
IRSC[214]={};IRSC[214][0]=1.00;IRSC[214][1]=0.25;IRSC[214][2]=0.25;
IRSC[215]={};IRSC[215][0]=1.00;IRSC[215][1]=0.25;IRSC[215][2]=0.25;
IRSC[216]={};IRSC[216][0]=1.00;IRSC[216][1]=0.25;IRSC[216][2]=0.25;
IRSC[217]={};IRSC[217][0]=1.00;IRSC[217][1]=0.25;IRSC[217][2]=0.25;
IRSC[218]={};IRSC[218][0]=1.00;IRSC[218][1]=0.25;IRSC[218][2]=0.25;
IRSC[219]={};IRSC[219][0]=1.00;IRSC[219][1]=0.25;IRSC[219][2]=0.25;
IRSC[220]={};IRSC[220][0]=0.50;IRSC[220][1]=0.50;IRSC[220][2]=1.00;
IRSC[221]={};IRSC[221][0]=0.50;IRSC[221][1]=0.50;IRSC[221][2]=1.00;
IRSC[222]={};IRSC[222][0]=1.00;IRSC[222][1]=0.25;IRSC[222][2]=0.25;
IRSC[223]={};IRSC[223][0]=0.25;IRSC[223][1]=1.00;IRSC[223][2]=0.25;
IRSC[224]={};IRSC[224][0]=1.00;IRSC[224][1]=0.25;IRSC[224][2]=0.25;
IRSC[225]={};IRSC[225][0]=1.00;IRSC[225][1]=0.25;IRSC[225][2]=0.25;
IRSC[226]={};IRSC[226][0]=1.00;IRSC[226][1]=0.25;IRSC[226][2]=0.25;
IRSC[227]={};IRSC[227][0]=1.00;IRSC[227][1]=0.25;IRSC[227][2]=0.25;
IRSC[228]={};IRSC[228][0]=1.00;IRSC[228][1]=0.25;IRSC[228][2]=0.25;
IRSC[229]={};IRSC[229][0]=0.25;IRSC[229][1]=1.00;IRSC[229][2]=0.25;
IRSC[230]={};IRSC[230][0]=0.25;IRSC[230][1]=1.00;IRSC[230][2]=0.25;
IRSC[231]={};IRSC[231][0]=0.25;IRSC[231][1]=1.00;IRSC[231][2]=0.25;
IRSC[232]={};IRSC[232][0]=0.25;IRSC[232][1]=1.00;IRSC[232][2]=0.25;
IRSC[233]={};IRSC[233][0]=0.25;IRSC[233][1]=1.00;IRSC[233][2]=0.25;
IRSC[234]={};IRSC[234][0]=0.50;IRSC[234][1]=0.50;IRSC[234][2]=1.00;
IRSC[235]={};IRSC[235][0]=1.00;IRSC[235][1]=0.25;IRSC[235][2]=0.25;
IRSC[236]={};IRSC[236][0]=1.00;IRSC[236][1]=0.25;IRSC[236][2]=0.25;
IRSC[237]={};IRSC[237][0]=1.00;IRSC[237][1]=0.25;IRSC[237][2]=0.25;
IRSC[238]={};IRSC[238][0]=1.00;IRSC[238][1]=0.25;IRSC[238][2]=0.25;
IRSC[239]={};IRSC[239][0]=1.00;IRSC[239][1]=0.25;IRSC[239][2]=0.25;
IRSC[240]={};IRSC[240][0]=1.00;IRSC[240][1]=0.25;IRSC[240][2]=0.25;
IRSC[241]={};IRSC[241][0]=1.00;IRSC[241][1]=0.25;IRSC[241][2]=0.25;
IRSC[242]={};IRSC[242][0]=1.00;IRSC[242][1]=0.25;IRSC[242][2]=0.25;
IRSC[243]={};IRSC[243][0]=1.00;IRSC[243][1]=0.25;IRSC[243][2]=0.25;
IRSC[244]={};IRSC[244][0]=1.00;IRSC[244][1]=0.25;IRSC[244][2]=0.25;
IRSC[245]={};IRSC[245][0]=1.00;IRSC[245][1]=0.25;IRSC[245][2]=0.25;
IRSC[246]={};IRSC[246][0]=1.00;IRSC[246][1]=0.65;IRSC[246][2]=0.00;
IRSC[247]={};IRSC[247][0]=1.00;IRSC[247][1]=0.65;IRSC[247][2]=0.00;
IRSC[248]={};IRSC[248][0]=1.00;IRSC[248][1]=0.65;IRSC[248][2]=0.00;
IRSC[249]={};IRSC[249][0]=1.00;IRSC[249][1]=0.25;IRSC[249][2]=0.25;
IRSC[250]={};IRSC[250][0]=1.00;IRSC[250][1]=0.25;IRSC[250][2]=0.25;
IRSC[251]={};IRSC[251][0]=1.00;IRSC[251][1]=0.25;IRSC[251][2]=0.25;
IRSC[252]={};IRSC[252][0]=0.25;IRSC[252][1]=1.00;IRSC[252][2]=0.25;
IRSC[253]={};IRSC[253][0]=0.50;IRSC[253][1]=0.50;IRSC[253][2]=1.00;
IRSC[254]={};IRSC[254][0]=0.50;IRSC[254][1]=0.50;IRSC[254][2]=1.00;
IRSC[255]={};IRSC[255][0]=0.50;IRSC[255][1]=0.50;IRSC[255][2]=1.00;
IRSC[256]={};IRSC[256][0]=0.50;IRSC[256][1]=0.50;IRSC[256][2]=1.00;
IRSC[257]={};IRSC[257][0]=0.50;IRSC[257][1]=0.50;IRSC[257][2]=1.00;
IRSC[258]={};IRSC[258][0]=1.00;IRSC[258][1]=0.25;IRSC[258][2]=0.25;
IRSC[259]={};IRSC[259][0]=1.00;IRSC[259][1]=0.25;IRSC[259][2]=0.25;
IRSC[260]={};IRSC[260][0]=1.00;IRSC[260][1]=0.25;IRSC[260][2]=0.25;
IRSC[261]={};IRSC[261][0]=0.25;IRSC[261][1]=1.00;IRSC[261][2]=0.25;
IRSC[262]={};IRSC[262][0]=1.00;IRSC[262][1]=0.25;IRSC[262][2]=0.25;
IRSC[263]={};IRSC[263][0]=1.00;IRSC[263][1]=0.25;IRSC[263][2]=0.25;
IRSC[264]={};IRSC[264][0]=1.00;IRSC[264][1]=0.25;IRSC[264][2]=0.25;
IRSC[265]={};IRSC[265][0]=1.00;IRSC[265][1]=0.65;IRSC[265][2]=0.00;
IRSC[266]={};IRSC[266][0]=1.00;IRSC[266][1]=0.65;IRSC[266][2]=0.00;
IRSC[267]={};IRSC[267][0]=0.25;IRSC[267][1]=1.00;IRSC[267][2]=0.25;
IRSC[268]={};IRSC[268][0]=0.25;IRSC[268][1]=1.00;IRSC[268][2]=0.25;
IRSC[269]={};IRSC[269][0]=0.25;IRSC[269][1]=1.00;IRSC[269][2]=0.25;
IRSC[270]={};IRSC[270][0]=0.25;IRSC[270][1]=1.00;IRSC[270][2]=0.25;
IRSC[271]={};IRSC[271][0]=0.25;IRSC[271][1]=1.00;IRSC[271][2]=0.25;
IRSC[272]={};IRSC[272][0]=0.25;IRSC[272][1]=1.00;IRSC[272][2]=0.25;
IRSC[273]={};IRSC[273][0]=0.25;IRSC[273][1]=1.00;IRSC[273][2]=0.25;
IRSC[274]={};IRSC[274][0]=1.00;IRSC[274][1]=0.25;IRSC[274][2]=0.25;
IRSC[275]={};IRSC[275][0]=0.50;IRSC[275][1]=0.50;IRSC[275][2]=1.00;
IRSC[276]={};IRSC[276][0]=0.50;IRSC[276][1]=0.50;IRSC[276][2]=1.00;
IRSC[277]={};IRSC[277][0]=0.50;IRSC[277][1]=0.50;IRSC[277][2]=1.00;
IRSC[278]={};IRSC[278][0]=1.00;IRSC[278][1]=0.25;IRSC[278][2]=0.25;
IRSC[279]={};IRSC[279][0]=0.25;IRSC[279][1]=1.00;IRSC[279][2]=0.25;
IRSC[280]={};IRSC[280][0]=0.25;IRSC[280][1]=1.00;IRSC[280][2]=0.25;
IRSC[281]={};IRSC[281][0]=0.25;IRSC[281][1]=1.00;IRSC[281][2]=0.25;
IRSC[282]={};IRSC[282][0]=1.00;IRSC[282][1]=0.65;IRSC[282][2]=0.00;
IRSC[283]={};IRSC[283][0]=1.00;IRSC[283][1]=0.65;IRSC[283][2]=0.00;
IRSC[284]={};IRSC[284][0]=1.00;IRSC[284][1]=0.65;IRSC[284][2]=0.00;
IRSC[285]={};IRSC[285][0]=1.00;IRSC[285][1]=0.65;IRSC[285][2]=0.00;
IRSC[286]={};IRSC[286][0]=1.00;IRSC[286][1]=0.65;IRSC[286][2]=0.00;
IRSC[287]={};IRSC[287][0]=1.00;IRSC[287][1]=0.65;IRSC[287][2]=0.00;
IRSC[288]={};IRSC[288][0]=1.00;IRSC[288][1]=0.65;IRSC[288][2]=0.00;
IRSC[289]={};IRSC[289][0]=1.00;IRSC[289][1]=0.65;IRSC[289][2]=0.00;
IRSC[290]={};IRSC[290][0]=0.50;IRSC[290][1]=0.50;IRSC[290][2]=1.00;
IRSC[291]={};IRSC[291][0]=1.00;IRSC[291][1]=0.25;IRSC[291][2]=0.25;
IRSC[292]={};IRSC[292][0]=0.25;IRSC[292][1]=1.00;IRSC[292][2]=0.25;
IRSC[293]={};IRSC[293][0]=0.25;IRSC[293][1]=1.00;IRSC[293][2]=0.25;
IRSC[294]={};IRSC[294][0]=0.50;IRSC[294][1]=0.50;IRSC[294][2]=1.00;
IRSC[295]={};IRSC[295][0]=0.50;IRSC[295][1]=0.50;IRSC[295][2]=1.00;
IRSC[296]={};IRSC[296][0]=1.00;IRSC[296][1]=0.25;IRSC[296][2]=0.25;
IRSC[297]={};IRSC[297][0]=1.00;IRSC[297][1]=0.25;IRSC[297][2]=0.25;
IRSC[298]={};IRSC[298][0]=1.00;IRSC[298][1]=0.25;IRSC[298][2]=0.25;
IRSC[299]={};IRSC[299][0]=1.00;IRSC[299][1]=0.25;IRSC[299][2]=0.25;
IRSC[300]={};IRSC[300][0]=1.00;IRSC[300][1]=0.25;IRSC[300][2]=0.25;
IRSC[301]={};IRSC[301][0]=0.50;IRSC[301][1]=0.50;IRSC[301][2]=1.00;
IRSC[302]={};IRSC[302][0]=0.50;IRSC[302][1]=0.50;IRSC[302][2]=1.00;
IRSC[303]={};IRSC[303][0]=1.00;IRSC[303][1]=0.25;IRSC[303][2]=0.25;
IRSC[304]={};IRSC[304][0]=1.00;IRSC[304][1]=0.25;IRSC[304][2]=0.25;
IRNRL[1]=45.00
IRNRL[2]=60.00
IRNRL[3]=275.00
IRNRL[4]=25.00
IRNRL[5]=35.00
IRNRL[6]=5000.00
IRNRL[7]=5000.00
IRNRL[8]=10.00
IRNRL[9]=10.00
IRNRL[10]=10.00
IRNRL[11]=10.00
IRNRL[12]=10.00
IRNRL[13]=300.00
IRNRL[14]=30.00
IRNRL[15]=30.00
IRNRL[16]=30.00
IRNRL[17]=30.00
IRNRL[18]=30.00
IRNRL[19]=30.00
IRNRL[20]=150.00
IRNRL[21]=180.00
IRNRL[22]=90.00
IRNRL[23]=100.00
IRNRL[24]=90.00
IRNRL[25]=172.00
IRNRL[26]=112.00
IRNRL[27]=74.00
IRNRL[28]=171.00
IRNRL[29]=178.00
IRNRL[30]=178.00
IRNRL[31]=178.00
IRNRL[32]=40.00
IRNRL[33]=50.00
IRNRL[34]=60.00
IRNRL[35]=178.00
IRNRL[36]=178.00
IRNRL[37]=178.00
IRNRL[38]=40.00
IRNRL[39]=50.00
IRNRL[40]=60.00
IRNRL[41]=60.00
IRNRL[42]=120.00
IRNRL[43]=227.00
IRNRL[44]=114.00
IRNRL[45]=18.00
IRNRL[46]=172.00
IRNRL[47]=18.00
IRNRL[48]=50.00
IRNRL[49]=50.00
IRNRL[50]=18.00
IRNRL[51]=60.00
IRNRL[52]=120.00
IRNRL[53]=75.00
IRNRL[54]=375.00
IRNRL[55]=18.00
IRNRL[56]=10.00
IRNRL[57]=10.00
IRNRL[58]=2.00
IRNRL[59]=3.00
IRNRL[60]=500.00
IRNRL[61]=180.00
IRNRL[62]=77.00
IRNRL[63]=95.00
IRNRL[64]=95.00
IRNRL[65]=135.00
IRNRL[66]=117.00
IRNRL[67]=110.00
IRNRL[68]=0.10
IRNRL[69]=0.10
IRNRL[70]=0.10
IRNRL[71]=0.10
IRNRL[72]=2.00
IRNRL[73]=3.10
IRNRL[74]=30.00
IRNRL[75]=1.10
IRNRL[76]=60.00
IRNRL[77]=1.60
IRNRL[78]=40.00
IRNRL[79]=1.60
IRNRL[80]=50.10
IRNRL[81]=5.10
IRNRL[82]=30.10
IRNRL[83]=2.60
IRNRL[84]=50.10
IRNRL[85]=400.00
IRNRL[86]=1.10
IRNRL[87]=1.10
IRNRL[88]=1.10
IRNRL[89]=1.10
IRNRL[90]=2000.00
IRNRL[91]=1.10
IRNRL[92]=2.00
IRNRL[93]=100.00
IRNRL[94]=100.00
IRNRL[95]=100.00
IRNRL[96]=15.00
IRNRL[97]=10.00
IRNRL[98]=10.00
IRNRL[99]=10.00
IRNRL[100]=10.00
IRNRL[101]=100.00
IRNRL[102]=100.00
IRNRL[103]=100.00
IRNRL[104]=10.00
IRNRL[105]=110.00
IRNRL[106]=40.00
IRNRL[107]=20.00
IRNRL[108]=20.00
IRNRL[109]=200.00
IRNRL[110]=2.00
IRNRL[111]=150.00
IRNRL[112]=1.90
IRNRL[113]=200.00
IRNRL[114]=1.00
IRNRL[115]=100.00
IRNRL[116]=10.00
IRNRL[117]=100.00
IRNRL[118]=100.00
IRNRL[119]=1.80
IRNRL[120]=2.60
IRNRL[121]=10.00
IRNRL[122]=2.00
IRNRL[123]=200.00
IRNRL[124]=100.00
IRNRL[125]=3.10
IRNRL[126]=1.60
IRNRL[127]=2.60
IRNRL[128]=3.10
IRNRL[129]=1.10
IRNRL[130]=1.60
IRNRL[131]=1.60
IRNRL[132]=5.00
IRNRL[133]=5.00
IRNRL[134]=200.00
IRNRL[135]=1.10
IRNRL[136]=20.00
IRNRL[137]=0.10
IRNRL[138]=2000.00
IRNRL[139]=1.00
IRNRL[140]=2000.00
IRNRL[141]=5.00
IRNRL[142]=2000.00
IRNRL[143]=10.00
IRNRL[144]=2.00
IRNRL[145]=100.00
IRNRL[146]=3.10
IRNRL[147]=3.00
IRNRL[148]=5.00
IRNRL[149]=5.00
IRNRL[150]=2.00
IRNRL[151]=100.00
IRNRL[152]=100.00
IRNRL[153]=100.00
IRNRL[154]=100.00
IRNRL[155]=100.00
IRNRL[156]=100.00
IRNRL[157]=100.00
IRNRL[158]=100.00
IRNRL[159]=100.00
IRNRL[160]=100.00
IRNRL[161]=2.10
IRNRL[162]=100.00
IRNRL[163]=2.10
IRNRL[164]=100.00
IRNRL[165]=10.00
IRNRL[166]=10.00
IRNRL[167]=10.00
IRNRL[168]=4.10
IRNRL[169]=4.10
IRNRL[170]=14.00
IRNRL[171]=14.00
IRNRL[172]=62.00
IRNRL[173]=62.00
IRNRL[174]=10.00
IRNRL[175]=10.00
IRNRL[176]=1.10
IRNRL[177]=1.10
IRNRL[178]=10.10
IRNRL[179]=100.00
IRNRL[180]=100.00
IRNRL[181]=100.00
IRNRL[182]=100.00
IRNRL[183]=100.00
IRNRL[184]=100.00
IRNRL[185]=100.00
IRNRL[186]=100.00
IRNRL[187]=100.00
IRNRL[188]=100.00
IRNRL[189]=100.00
IRNRL[190]=100.00
IRNRL[191]=100.00
IRNRL[192]=100.00
IRNRL[193]=100.00
IRNRL[194]=100.00
IRNRL[195]=100.00
IRNRL[196]=100.00
IRNRL[197]=100.00
IRNRL[198]=100.00
IRNRL[199]=100.00
IRNRL[200]=100.00
IRNRL[201]=100.00
IRNRL[202]=100.00
IRNRL[203]=100.00
IRNRL[204]=100.00
IRNRL[205]=100.00
IRNRL[206]=100.00
IRNRL[207]=100.00
IRNRL[208]=100.00
IRNRL[209]=100.00
IRNRL[210]=100.00
IRNRL[211]=100.00
IRNRL[212]=100.00
IRNRL[213]=100.00
IRNRL[214]=100.00
IRNRL[215]=100.00
IRNRL[216]=100.00
IRNRL[217]=100.00
IRNRL[218]=100.00
IRNRL[219]=100.00
IRNRL[220]=50.00
IRNRL[221]=50.00
IRNRL[222]=12.00
IRNRL[223]=12.00
IRNRL[224]=100.00
IRNRL[225]=2.60
IRNRL[226]=2.60
IRNRL[227]=1.10
IRNRL[228]=1.60
IRNRL[229]=5.00
IRNRL[230]=5.00
IRNRL[231]=20.00
IRNRL[232]=20.00
IRNRL[233]=3.00
IRNRL[234]=100.00
IRNRL[235]=100.00
IRNRL[236]=100.00
IRNRL[237]=5.10
IRNRL[238]=4.10
IRNRL[239]=3.10
IRNRL[240]=5.10
IRNRL[241]=5.10
IRNRL[242]=5.10
IRNRL[243]=4.10
IRNRL[244]=8.10
IRNRL[245]=5.10
IRNRL[246]=100.00
IRNRL[247]=100.00
IRNRL[248]=100.00
IRNRL[249]=150.00
IRNRL[250]=150.00
IRNRL[251]=150.00
IRNRL[252]=150.00
IRNRL[253]=100.00
IRNRL[254]=100.00
IRNRL[255]=100.00
IRNRL[256]=100.00
IRNRL[257]=100.00
IRNRL[258]=100.00
IRNRL[259]=100.00
IRNRL[260]=100.00
IRNRL[261]=2.10
IRNRL[262]=100.00
IRNRL[263]=100.00
IRNRL[264]=100.00
IRNRL[265]=1.00
IRNRL[266]=1.00
IRNRL[267]=0.05
IRNRL[268]=0.05
IRNRL[269]=0.05
IRNRL[270]=0.05
IRNRL[271]=0.05
IRNRL[272]=0.05
IRNRL[273]=2.10
IRNRL[274]=2.10
IRNRL[275]=10.00
IRNRL[276]=100.00
IRNRL[277]=100.00
IRNRL[278]=25.00
IRNRL[279]=1000.00
IRNRL[280]=10.00
IRNRL[281]=120.00
IRNRL[282]=10.00
IRNRL[283]=10.00
IRNRL[284]=10.00
IRNRL[285]=10.00
IRNRL[286]=10.00
IRNRL[287]=21.00
IRNRL[288]=10.00
IRNRL[289]=48.00
IRNRL[290]=100.00
IRNRL[291]=150.00
IRNRL[292]=300.00
IRNRL[293]=10.00
IRNRL[294]=10.00
IRNRL[295]=1.10
IRNRL[296]=5.00
IRNRL[297]=10.00
IRNRL[298]=15.00
IRNRL[299]=5.00
IRNRL[300]=10.00
IRNRL[301]=100.00
IRNRL[302]=40.00
IRNRL[303]=0.80
IRNRL[304]=50.00
IRT[1]="Base damage modifier. Gets converted into attack power. Increases shield block value"
IRT[2]="Base damage modifier. Gets converted into attack power. Increases armor. Increases crit chance for some classes. Increases dodge chance."
IRT[3]="Increases max health"
IRT[4]="Increases max mana. Increases mana regen. Increases crit chance for some classes."
IRT[5]="Increases mana regen."
IRT[6]="If this gets to 0, you die."
IRT[7]="Resource for spells."
IRT[8]="Resource for abilities."
IRT[9]="Resource for abilities."
IRT[10]="Resource for abilities."
IRT[11]="Resource for abilities."
IRT[12]="Resource for abilities."
IRT[13]="Reduces physical damage taken."
IRT[14]="Reduces holy damage taken."
IRT[15]="Reduces fire damage taken."
IRT[16]="Reduces nature damage taken."
IRT[17]="Reduces frost damage taken."
IRT[18]="Reduces shadow damage taken."
IRT[19]="Reduces arcane damage taken."
IRT[20]="Increases melee damage and ability damage"
IRT[21]="Increases ranged damage and ability damage"
IRT[22]="Increases damage when using mainhand weapon( attack or ability )"
IRT[23]="Increases damage when using offhand weapon( attack or ability )"
IRT[24]="Increases damage when using ranged weapon( attack or ability )"
IRT[25]="Reduce the chance for an enemy attack to do damage"
IRT[26]="Reduce the chance for an enemy attack to do damage"
IRT[27]="Chance for an enemy attack to be reduced by block amount"
IRT[28]="Chance for an enemy to do reduced damage"
IRT[29]="Increases the chance you will hit an enemy with melee attack"
IRT[30]="Increases the chance you will hit an enemy with ranged attack"
IRT[31]="Increases the chance you will hit an enemy with spells"
IRT[32]="Increases the chance you will critically hit an enemy with melee attack"
IRT[33]="Increases the chance you will critically hit an enemy with ranged attack"
IRT[34]="Increases the chance you will critically hit an enemy with spells"
IRT[35]="Reduces the chance you will be hit by an enemy with melee attack"
IRT[36]="Reduces the chance you will be hit by an enemy with ranged attack"
IRT[37]="Reduces the chance you will be hit by an enemy with spell attack"
IRT[38]="Reduces the chance you will be critically hit by an enemy with melee attack"
IRT[39]="Reduces the chance you will be critically hit by an enemy with ranged attack"
IRT[40]="Reduces the chance you will be critically hit by an enemy with spells"
IRT[41]="Reduces the time between melee attacks"
IRT[42]="Reduces the time between ranged attacks"
IRT[43]="Reduces cast time of spells"
IRT[44]="Reduces the dodge chance of your target"
IRT[45]="Reduces the physical resistance of your target"
IRT[46]="Increses the chance your attacks will deal damage ( melee/ranged/spell)"
IRT[47]="Increses the chance your attacks will deal critical damage ( melee/ranged/spell)"
IRT[48]="Reduces the chance you will be hit by melee/ranged/spell damage"
IRT[49]="Reduces the chance you will be hit by critical melee/ranged/spell damage"
IRT[50]="Reduces critcal damage taken from melee/ranged/spells"
IRT[51]="Reduces time between melee/ranged/spells attacks"
IRT[52]="Increases the amount of mana regenerated periodically"
IRT[53]="Increases the power of spells. Mostly damage and absorb"
IRT[54]="Increases the amount of health you regenrate while out of combat"
IRT[55]="Spell damage will ignore resistance"
IRT[56]="Every 100 magic find will give you 1 extra item stat on looted items. Instance difficulty counts as Magic Find"
IRT[57]="Increases the strength of randomly rolled stats"
IRT[58]="Increases movement speed ( not mounted )"
IRT[59]="Increases movement speed while mounted"
IRT[60]="Increases physical damage. Base value"
IRT[61]="Increases holy damage. Base value"
IRT[62]="Increases fire damage. Base value"
IRT[63]="Increases nature damage. Base value"
IRT[64]="Increases frost damage. Base value"
IRT[65]="Increases shadow damage. Base value"
IRT[66]="Increases arcane damage. Base value"
IRT[67]="Increases healing taken. Periodic heals will split up this value between ticks"
IRT[68]="Base damage is increased based on target current health"
IRT[69]="Base damage is increased based on target missing health"
IRT[70]="Heal amount is increased based on target current health. Periodic heals will split up this value between ticks"
IRT[71]="Heal amount is increased based on target missing health. Periodic heals will split up this value between ticks"
IRT[72]="Aura duration increase. Not all spells benefit from it"
IRT[73]="Aura duration increase. Not all spells benefit from it"
IRT[74]="Spell damage increase. Not all spells benefit from it"
IRT[75]="Spell damage increase. Not all spells benefit from it"
IRT[76]="Spell periodic damage increase. Not all spells benefit from it"
IRT[77]="Spell periodic damage increase. Not all spells benefit from it"
IRT[78]="When a spell crits, the damage will receive extra bonus. Not all spells benefit from it"
IRT[79]="When a spell crits, the damage will receive extra bonus. Not all spells benefit from it"
IRT[80]="Increases the threath you generate with abilities"
IRT[81]="Increases the chance you will only loot items that can be equipped"
IRT[82]="Increases bonus damage when you deal critical melee damage"
IRT[83]="Increases bonus damage when you deal critical ranged damage"
IRT[84]="Increases the threath you generate with abilities"
IRT[85]="Increases health you generate periodically, even while in combat"
IRT[86]="Increases health you generate periodically, even while in combat"
IRT[87]="Increases health you generate periodically, even while in combat. Amount is based on missing health"
IRT[88]="Increases health you generate periodically, even while in combat. Amount is based on curent health"
IRT[89]="Increases mana you generate periodically, even while in combat"
IRT[90]="Converts victim mana into damage you deal"
IRT[91]="Converts victim mana into damage you deal"
IRT[92]="Spells will be casted on additional targets. Not all spells can benefit from it"
IRT[93]="You can wield weapons in offhand"
IRT[94]="You can wield 2 handed weapons in offhand. Does not give ability to dual wield"
IRT[95]="Attacks have a chance to ckick back victim"
IRT[96]="Increases heal amount when you score a critical heal."
IRT[97]="Increases the chance your mellee/ranged/spell attacks will deal damage."
IRT[98]="Increases the chance your spell attacks will deal damage."
IRT[99]="As long as you have mana, percent of the damage taken will be taken from mana instead. Value refers to percent of damage converted"
IRT[100]="As long as you have mana, damage taken will be taken from mana instead. Value refers to damage to mana conversion ratio."
IRT[101]="Gain the ability to walk above water"
IRT[102]="Gain the ability to fall slowly to avoid damage taken"
IRT[103]="Walk above the ground. Cause it looks special"
IRT[104]="Increase the amount of healing you take"
IRT[105]="Increase the amount of healing you do"
IRT[106]="Increase the amount of healing you do"
IRT[107]="Every 100 Magic Find will give 1 additional item stat for crafted, bought items"
IRT[108]="Increases the strength of random stats on crafted or bought items"
IRT[109]="Health is increased every time you deal damage"
IRT[110]="Health is increased every time you deal damage"
IRT[111]="Burn your own mana to increase damage done. This is considered bonus damage"
IRT[112]="Increase damage done based on how low is your power bar. This is considered bonus damage"
IRT[113]="Increase mana based on damage taken"
IRT[114]="Increase mana based on damage taken"
IRT[115]="When some damage would kill you, cancel that damage, and cast spell on you instead"
IRT[116]="Extra gold you receive when you loot monsters"
IRT[117]="When some damage would kill you, cancel that damage, and cast spell on you instead"
IRT[118]="When some damage would kill you, cancel that damage, and cast spell on you instead"
IRT[119]="You sometimes deal more damage, sometimes deal less damage. Made for caster rotations"
IRT[120]="Cast spells faster"
IRT[121]="When your victim dies because of your damage, it will explode and deal area damage based on he's maximum health"
IRT[122]="Damage received will charge up a chain lightning that will periodically get casted"
IRT[123]="Damage reduction based on the number of agroed units. Made for tanks to pull half of the map"
IRT[124]="Tanks can soak up a lot of damage. Teamwork can make them become a damage dealer"
IRT[125]="Tanks can soak up a lot of damage. Teamwork can make them become a damage dealer"
IRT[126]="Incease strength based on a percent value. Strength increases attack power. Increases shield block value"
IRT[127]="Incease agility based on a percent value. Agility attack power.Increases armor.Increases crit chance for some classes.Increases dodge chance."
IRT[128]="Incease stamina based on a percent value. Stamina increases max health."
IRT[129]="Increases max mana. Increases mana regen. Increases crit chance for some classes."
IRT[130]="Increases mana regen."
IRT[131]="Increases all base stats by a percent value."
IRT[132]="When you receive damage while casting, the amount of spell cast delay will be reduced."
IRT[133]="Decrease the global cooldown of some of the spells/abilities. Value is in milliseconds"
IRT[134]="The more players are in your raid group, the less damage you take"
IRT[135]="The more players are in your raid group, the less damage you take"
IRT[136]="The more players are in your raid group, the damage damage you deal"
IRT[137]="The more players are in your raid group, the damage damage you deal"
IRT[138]="Part of the damage you would take, will be taken from money instead"
IRT[139]="Extra talent points you can spend. You should spend these as soon as possible to avoid bugouts"
IRT[140]="Nearby tanks will also take part of the damage. Damage can not be mitigated"
IRT[141]="Nearby tanks will also take part of the damage. Damage can not be mitigated"
IRT[142]="Nearby casters will also take part of the damage. Damage can not be mitigated"
IRT[143]="Nearby tanks will also take part of the damage. Damage can not be mitigated"
IRT[144]="Cast a long cooldown spell, than spam some instant spells to reduce the large cooldown"
IRT[145]="As long as your health is below 20%, you will deal aditional damage"
IRT[146]="As long as your health is below 20%, you will deal aditional damage"
IRT[147]="As long as your health is below 20%, you have additional chance that attacks will not deal damage"
IRT[148]="As long as your health is below 20%, you will take reduced damage"
IRT[149]="When you loot an item, each stat has a specific chance to be rolled on the item based on it's impact. Some roll chances are negative by default. Increases the roll chance of all stats"
IRT[150]="When you take damage, if the damage is larger than x% of your health, it will be reduced to not exceed the trashold"
IRT[151]="Gain aura that does not have duration"
IRT[152]="Gain aura that does not have duration"
IRT[153]="Gain aura that does not have duration"
IRT[154]="Gain cosmetic look"
IRT[155]="Uppon death, if you own the reagent, you are able to revive yourself"
IRT[156]="Heal received has a chance to dispel/cure a debuff"
IRT[157]="When some damage would kill you, cancel that damage, and cast spell on you instead"
IRT[158]="When you receive damage, you have a chance to jump backwards automatically"
IRT[159]="When you heal your target, he has a chance to cast stormstrike for free"
IRT[160]="When you take damage, you have a chance to clear the cooldown of your healing potions"
IRT[161]="Healing taken while you are on maximum health, will increase your damage"
IRT[162]="When you cast an aura that can only target yourself, party members have a chance to also cast that spell on themself"
IRT[163]="The more health you have, the more healing you can do"
IRT[164]="Chance to repeat the spell cast instnatly and for free"
IRT[165]="When you loot an item, each stat has a specific chance to be rolled on the item based on it's impact. Some roll chances are negative by default. Increases the roll chance of all utility stats"
IRT[166]="When you loot an item, each stat has a specific chance to be rolled on the item based on it's impact. Some roll chances are negative by default. Increases the roll chance of all attack stats"
IRT[167]="When you loot an item, each stat has a specific chance to be rolled on the item based on it's impact. Some roll chances are negative by default. Increases the roll chance of all defense stats"
IRT[168]="Based on yhe lifetime of this character, each unique monster kill will increase your damage forever"
IRT[169]="Based on yhe lifetime of this character, each unique monster kill will increase your healing forever"
IRT[170]="Based on yhe lifetime of this character, each unique item used will increase your damage forever"
IRT[171]="Based on yhe lifetime of this character, each unique item used will increase your heal forever"
IRT[172]="Based on yhe lifetime of this character, each unique achievement earned will increase your damage forever"
IRT[173]="Based on yhe lifetime of this character, each unique achievement earned will increase your healing forever"
IRT[174]="Based on yhe lifetime of this character, each unique quest finished will increase your damage forever"
IRT[175]="Based on yhe lifetime of this character, each unique quest finished will increase your healing forever"
IRT[176]="Based on yhe lifetime of this character, each unique honorable kill will increase your damage forever. The damage stacking slows down after a while, but does not stop"
IRT[177]="Based on yhe lifetime of this character, each unique honorable kill will increase your healing forever. The healing stacking slows down after a while, but does not stop"
IRT[178]="Spell casting will cost less"
IRT[179]="You will be able to use this item class"
IRT[180]="You will be able to use this item class"
IRT[181]="You will be able to use this item class"
IRT[182]="You will be able to use this item class"
IRT[183]="You will be able to use this item class"
IRT[184]="You will be able to use this item class"
IRT[185]="You will be able to use this item class"
IRT[186]="You will be able to use this item class"
IRT[187]="You will be able to use this item class"
IRT[188]="You will be able to use this item class"
IRT[189]="You will be able to use this item class"
IRT[190]="You will be able to use this item class"
IRT[191]="You will be able to use this item class"
IRT[192]="You will learn this spell. Succubus is a caster helper summon"
IRT[193]="You will learn this spell. This is a gap closer spell before you engage combat"
IRT[194]="You will learn this spell. You will generate mana after casting the spell"
IRT[195]="You will learn this spell. Target armor will be increased"
IRT[196]="You will learn this spell. Attackers might become rooted"
IRT[197]="You will learn this spell. You will be able to revive dead players"
IRT[198]="You will learn this spell. Defensive spell to avoid combat"
IRT[199]="You will learn this spell. Increases ranged attack speed"
IRT[200]="You will learn this spell. Spells deal more damage, but will also cost more mana"
IRT[201]="You will learn this spell. Interrupt spell casting of your target"
IRT[202]="You will learn this spell. You will generate mana after casting the spell"
IRT[203]="You will learn this spell. Increases the chance that you will critically hit with spells"
IRT[204]="You will learn this spell. Increases spell casting speed"
IRT[205]="You will learn this spell. Area damage based on weapon damage. Costs talent point to learn"
IRT[206]="You will learn this spell. Your attacks will have a chance to heal you"
IRT[207]="You will learn this spell. Channeled spell that heals and increases healing received of targeted party member"
IRT[208]="You will learn this spell. Channeled spell that restores mana of targeted party member"
IRT[209]="You will learn this spell. Increases critical chance and reduces spell cost of the next spell"
IRT[210]="You will learn this spell. Burn target mana for damage"
IRT[211]="You will learn this spell. Temporary increases health based on max health"
IRT[212]="You will learn this spell. Increases attack speed or party members"
IRT[213]="You will learn this spell. Reduces damage taken"
IRT[214]="You will learn this spell. Your attacks also hit an additional target"
IRT[215]="You will learn this spell. Your next ability will be a critical"
IRT[216]="You will learn this spell. Attack nearby targets"
IRT[217]="You will learn this spell. Randomly teleport and attack targets"
IRT[218]="You will learn this spell. Increases physical damage, also loose health based on max health"
IRT[219]="You will learn this spell. Weapon enchant that has a chance to trigger an additional attack"
IRT[220]="Your pet will receive additional threath from abilities"
IRT[221]="Your pet will deal damage to nearby targets"
IRT[222]="Your damage will increase based on the number of consecutive daily logins"
IRT[223]="Your heal will increase based on the number of consecutive daily logins"
IRT[224]="When you retarget, you have a chance to automatically cast charge even while in combat"
IRT[225]="Convert base stat to spell damage"
IRT[226]="Convert base stat to spell damage"
IRT[227]="Convert base stat to spell damage"
IRT[228]="Convert base stat to spell damage"
IRT[229]="Convert base stat to heal power"
IRT[230]="Convert base stat to heal power"
IRT[231]="Convert base stat to heal power"
IRT[232]="Convert base stat to heal power"
IRT[233]="Only works if you have an active damage abosb aura. You will also receive the healing effect"
IRT[234]="Chance to add a random item to the library of transmog items"
IRT[235]="As you move, you automatically cast a spell that damages players around you"
IRT[236]="As you move, you automatically cast the last spell you used on your target"
IRT[237]="Convert the amount of armor into attack power. Attack power increases physical damage"
IRT[238]="Convert base stat into attack power. Attack power increases physical damage"
IRT[239]="Convert base stat into attack power. Attack power increases physical damage"
IRT[240]="Convert base stat into attack power. Attack power increases physical damage"
IRT[241]="Convert base stat into attack power. Attack power increases physical damage"
IRT[242]="Convert base stat into attack power. Attack power increases physical damage"
IRT[243]="Convert base stat into attack power. Attack power increases physical damage"
IRT[244]="Convert base stat into attack power. Attack power increases physical damage"
IRT[245]="Convert base stat into attack power. Attack power increases physical damage"
IRT[246]="Character movement no longer interrupts spell casting"
IRT[247]="You can cast more than one spell at once. While a spell with long casting time is casted, you can cast another spell that will not interrupt it"
IRT[248]="You can cast spells even while not facing your target"
IRT[249]="The slower you attack, the stronger you hit"
IRT[250]="The slower you attack, the stronger you hit"
IRT[251]="The slower you attack, the stronger you hit"
IRT[252]="The slower you attack, the stronger you hit"
IRT[253]="Your damage will check for lowest resistance of the target. Your attacks now also check for this type of resistance. You can combine multiple damage types at once"
IRT[254]="Your damage will check for lowest resistance of the target. Your attacks now also check for this type of resistance. You can combine multiple damage types at once"
IRT[255]="Your damage will check for lowest resistance of the target. Your attacks now also check for this type of resistance. You can combine multiple damage types at once"
IRT[256]="Your damage will check for lowest resistance of the target. Your attacks now also check for this type of resistance. You can combine multiple damage types at once"
IRT[257]="Your damage will check for lowest resistance of the target. Your attacks now also check for this type of resistance. You can combine multiple damage types at once"
IRT[258]="The more health you have, the more damage you will deal with your jump landings"
IRT[259]="Automatically damage nearby enemies while casting a spell. Damage is based on the highest stat you have ( Except stamina )"
IRT[260]="You will automatically cast firebreath. The extra damage you deal is based on your single target damge you deal"
IRT[261]="The closer you are to your target, the more healing you do"
IRT[262]="You can periodically gain BloodLust when you take damage"
IRT[263]="The more you move without stopping, the higher you will explode when you will stop"
IRT[264]="Ability to use this item class"
IRT[265]="Extend the range of your spells"
IRT[266]="Some auras can stack up to X times"
IRT[267]="Convert physical resistance to elemental resistance. Resistance will reduce damage by percent value"
IRT[268]="Convert physical resistance to elemental resistance. Resistance will reduce damage by percent value"
IRT[269]="Convert physical resistance to elemental resistance. Resistance will reduce damage by percent value"
IRT[270]="Convert physical resistance to elemental resistance. Resistance will reduce damage by percent value"
IRT[271]="Convert physical resistance to elemental resistance. Resistance will reduce damage by percent value"
IRT[272]="Convert physical resistance to elemental resistance. Resistance will reduce damage by percent value"
IRT[273]="The more players are grouped in a small area, the more healing you do"
IRT[274]="The more players are grouped in a small area, the more damage you do"
IRT[275]="Magic dust is used to buy magical effects. Like boost drop chance of stats. The more stats you get, the more dust you gain..."
IRT[276]="You will learn this spell. You will teleport forward"
IRT[277]="You will learn this spell. Increases threath generated by holy spells"
IRT[278]="While continuesly killing enemies, your damage ramps up. Damage increase slows down after a while, but does not stop increasing"
IRT[279]="If your target is continuesly low health, you will heal him more and more as you continue healing him"
IRT[280]="Damage received is evened out over time. You no longer take very strong hits and very weak hits"
IRT[281]="Damage received drains health over time. Damage drain can not be mitigated by resistance or shields"
IRT[282]="Regenerate power required for spells and abilities"
IRT[283]="Regenerate power required for spells and abilities"
IRT[284]="Regenerate power required for spells and abilities"
IRT[285]="Regenerate power required for spells and abilities"
IRT[286]="Regenerate power required for spells and abilities"
IRT[287]="Regenerate power required for spells and abilities"
IRT[288]="Regenerate power required for spells and abilities"
IRT[289]="Regenerate power required for spells and abilities"
IRT[290]="Every time you kill something, you will gain sprint aura that increases your movement speed"
IRT[291]="Deal extra damage while behind your target"
IRT[292]="Receive less damage while attacker is in front of you"
IRT[293]="When you get healed, you also recover part of the damage you received previously"
IRT[294]="Increases experience gained. Experience contributes to paragon leveling"
IRT[295]="Single target damage is converted into an AOE explosion. This is done periodically. AOE damage does trigger procs and events"
IRT[296]="Part of damage done is copied to a chain lightning effect"
IRT[297]="Part of damage done is copied to a chain lightning effect"
IRT[298]="Part of damage done is copied to a chain lightning effect"
IRT[299]="Part of damage taken is copied to a chain lightning effect"
IRT[300]="Part of damage taken is copied to a chain lightning effect"
IRT[301]="You will learn this spell. Pull enemies closer to yourself"
IRT[302]="Reduce your own health to increase your damage"
IRT[303]="Increases your damage by percent value"
IRT[304]="Increases your damage by flat value"
