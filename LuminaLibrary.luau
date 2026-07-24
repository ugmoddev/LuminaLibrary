--[[
    Lumina Library - Complete Framework with Icons
    Version: 1.0.0
    A modern, production-ready Roblox UI framework with full icon support
]]

local Lumina = {}

-- ============================================================================
-- ICON SYSTEM
-- ============================================================================

local Icons = {
    ["accessibility"] = "rbxassetid://10709751939",
    ["activity"] = "rbxassetid://10709752035",
    ["airvent"] = "rbxassetid://10709752131",
    ["airplay"] = "rbxassetid://10709752254",
    ["alarmcheck"] = "rbxassetid://10709752405",
    ["alarmclock"] = "rbxassetid://10709752630",
    ["alarmclockoff"] = "rbxassetid://10709752508",
    ["alarmminus"] = "rbxassetid://10709752732",
    ["alarmplus"] = "rbxassetid://10709752825",
    ["album"] = "rbxassetid://10709752906",
    ["alertcircle"] = "rbxassetid://10709752996",
    ["alertoctagon"] = "rbxassetid://10709753064",
    ["alerttriangle"] = "rbxassetid://10709753149",
    ["aligncenter"] = "rbxassetid://10709753570",
    ["aligncenterhorizontal"] = "rbxassetid://10709753272",
    ["aligncentervertical"] = "rbxassetid://10709753421",
    ["alignendhorizontal"] = "rbxassetid://10709753692",
    ["alignendvertical"] = "rbxassetid://10709753808",
    ["alignhorizontaldistributecenter"] = "rbxassetid://10747779791",
    ["alignhorizontaldistributeend"] = "rbxassetid://10747784534",
    ["alignhorizontaldistributestart"] = "rbxassetid://10709754118",
    ["alignhorizontaljustifycenter"] = "rbxassetid://10709754204",
    ["alignhorizontaljustifyend"] = "rbxassetid://10709754317",
    ["alignhorizontaljustifystart"] = "rbxassetid://10709754436",
    ["alignhorizontalspacearound"] = "rbxassetid://10709754590",
    ["alignhorizontalspacebetween"] = "rbxassetid://10709754749",
    ["alignjustify"] = "rbxassetid://10709759610",
    ["alignleft"] = "rbxassetid://10709759764",
    ["alignright"] = "rbxassetid://10709759895",
    ["alignstarthorizontal"] = "rbxassetid://10709760051",
    ["alignstartvertical"] = "rbxassetid://10709760244",
    ["alignverticaldistributecenter"] = "rbxassetid://10709760351",
    ["alignverticaldistributeend"] = "rbxassetid://10709760434",
    ["alignverticaldistributestart"] = "rbxassetid://10709760612",
    ["alignverticaljustifycenter"] = "rbxassetid://10709760814",
    ["alignverticaljustifyend"] = "rbxassetid://10709761003",
    ["alignverticaljustifystart"] = "rbxassetid://10709761176",
    ["alignverticalspacearound"] = "rbxassetid://10709761324",
    ["alignverticalspacebetween"] = "rbxassetid://10709761434",
    ["anchor"] = "rbxassetid://10709761530",
    ["angry"] = "rbxassetid://10709761629",
    ["annoyed"] = "rbxassetid://10709761722",
    ["aperture"] = "rbxassetid://10709761813",
    ["apple"] = "rbxassetid://10709761889",
    ["archive"] = "rbxassetid://10709762233",
    ["archiverestore"] = "rbxassetid://10709762058",
    ["armchair"] = "rbxassetid://10709762327",
    ["arrowbigdown"] = "rbxassetid://10747796644",
    ["arrowbigleft"] = "rbxassetid://10709762574",
    ["arrowbigright"] = "rbxassetid://10709762727",
    ["arrowbigup"] = "rbxassetid://10709762879",
    ["arrowdown"] = "rbxassetid://10709767827",
    ["arrowdowncircle"] = "rbxassetid://10709763034",
    ["arrowdownleft"] = "rbxassetid://10709767656",
    ["arrowdownright"] = "rbxassetid://10709767750",
    ["arrowleft"] = "rbxassetid://10709768114",
    ["arrowleftcircle"] = "rbxassetid://10709767936",
    ["arrowleftright"] = "rbxassetid://10709768019",
    ["arrowright"] = "rbxassetid://10709768347",
    ["arrowrightcircle"] = "rbxassetid://10709768226",
    ["arrowup"] = "rbxassetid://10709768939",
    ["arrowupcircle"] = "rbxassetid://10709768432",
    ["arrowupdown"] = "rbxassetid://10709768538",
    ["arrowupleft"] = "rbxassetid://10709768661",
    ["arrowupright"] = "rbxassetid://10709768787",
    ["asterisk"] = "rbxassetid://10709769095",
    ["atsign"] = "rbxassetid://10709769286",
    ["award"] = "rbxassetid://10709769406",
    ["axe"] = "rbxassetid://10709769508",
    ["axis3d"] = "rbxassetid://10709769598",
    ["baby"] = "rbxassetid://10709769732",
    ["backpack"] = "rbxassetid://10709769841",
    ["baggageclaim"] = "rbxassetid://10709769935",
    ["banana"] = "rbxassetid://10709770005",
    ["banknote"] = "rbxassetid://10709770178",
    ["barchart"] = "rbxassetid://10709773755",
    ["barchart2"] = "rbxassetid://10709770317",
    ["barchart3"] = "rbxassetid://10709770431",
    ["barchart4"] = "rbxassetid://10709770560",
    ["barcharthorizontal"] = "rbxassetid://10709773669",
    ["barcode"] = "rbxassetid://10747360675",
    ["baseline"] = "rbxassetid://10709773863",
    ["bath"] = "rbxassetid://10709773963",
    ["battery"] = "rbxassetid://10709774640",
    ["batterycharging"] = "rbxassetid://10709774068",
    ["batteryfull"] = "rbxassetid://10709774206",
    ["batterylow"] = "rbxassetid://10709774370",
    ["batterymedium"] = "rbxassetid://10709774513",
    ["beaker"] = "rbxassetid://10709774756",
    ["bed"] = "rbxassetid://10709775036",
    ["beddouble"] = "rbxassetid://10709774864",
    ["bedsingle"] = "rbxassetid://10709774968",
    ["beer"] = "rbxassetid://10709775167",
    ["bell"] = "rbxassetid://10709775704",
    ["bellminus"] = "rbxassetid://10709775241",
    ["belloff"] = "rbxassetid://10709775320",
    ["bellplus"] = "rbxassetid://10709775448",
    ["bellring"] = "rbxassetid://10709775560",
    ["bike"] = "rbxassetid://10709775894",
    ["binary"] = "rbxassetid://10709776050",
    ["bitcoin"] = "rbxassetid://10709776126",
    ["bluetooth"] = "rbxassetid://10709776655",
    ["bluetoothconnected"] = "rbxassetid://10709776240",
    ["bluetoothoff"] = "rbxassetid://10709776344",
    ["bluetoothsearching"] = "rbxassetid://10709776501",
    ["bold"] = "rbxassetid://10747813908",
    ["bomb"] = "rbxassetid://10709781460",
    ["bone"] = "rbxassetid://10709781605",
    ["book"] = "rbxassetid://10709781824",
    ["bookopen"] = "rbxassetid://10709781717",
    ["bookmark"] = "rbxassetid://10709782154",
    ["bookmarkminus"] = "rbxassetid://10709781919",
    ["bookmarkplus"] = "rbxassetid://10709782044",
    ["bot"] = "rbxassetid://10709782230",
    ["box"] = "rbxassetid://10709782497",
    ["boxselect"] = "rbxassetid://10709782342",
    ["boxes"] = "rbxassetid://10709782582",
    ["briefcase"] = "rbxassetid://10709782662",
    ["brush"] = "rbxassetid://10709782758",
    ["bug"] = "rbxassetid://10709782845",
    ["building"] = "rbxassetid://10709783051",
    ["building2"] = "rbxassetid://10709782939",
    ["bus"] = "rbxassetid://10709783137",
    ["cake"] = "rbxassetid://10709783217",
    ["calculator"] = "rbxassetid://10709783311",
    ["calendar"] = "rbxassetid://10709789505",
    ["calendarcheck"] = "rbxassetid://10709783474",
    ["calendarcheck2"] = "rbxassetid://10709783392",
    ["calendarclock"] = "rbxassetid://10709783577",
    ["calendardays"] = "rbxassetid://10709783673",
    ["calendarheart"] = "rbxassetid://10709783835",
    ["calendarminus"] = "rbxassetid://10709783959",
    ["calendaroff"] = "rbxassetid://10709788784",
    ["calendarplus"] = "rbxassetid://10709788937",
    ["calendarrange"] = "rbxassetid://10709789053",
    ["calendarsearch"] = "rbxassetid://10709789200",
    ["calendarx"] = "rbxassetid://10709789407",
    ["calendarx2"] = "rbxassetid://10709789329",
    ["camera"] = "rbxassetid://10709789686",
    ["cameraoff"] = "rbxassetid://10747822677",
    ["car"] = "rbxassetid://10709789810",
    ["carrot"] = "rbxassetid://10709789960",
    ["cast"] = "rbxassetid://10709790097",
    ["charge"] = "rbxassetid://10709790202",
    ["check"] = "rbxassetid://10709790644",
    ["checkcircle"] = "rbxassetid://10709790387",
    ["checkcircle2"] = "rbxassetid://10709790298",
    ["checksquare"] = "rbxassetid://10709790537",
    ["chefhat"] = "rbxassetid://10709790757",
    ["cherry"] = "rbxassetid://10709790875",
    ["chevrondown"] = "rbxassetid://10709790948",
    ["chevronfirst"] = "rbxassetid://10709791015",
    ["chevronlast"] = "rbxassetid://10709791130",
    ["chevronleft"] = "rbxassetid://10709791281",
    ["chevronright"] = "rbxassetid://10709791437",
    ["chevronup"] = "rbxassetid://10709791523",
    ["chevronsdown"] = "rbxassetid://10709796864",
    ["chevronsdownup"] = "rbxassetid://10709791632",
    ["chevronsleft"] = "rbxassetid://10709797151",
    ["chevronsleftright"] = "rbxassetid://10709797006",
    ["chevronsright"] = "rbxassetid://10709797382",
    ["chevronsrightleft"] = "rbxassetid://10709797274",
    ["chevronsup"] = "rbxassetid://10709797622",
    ["chevronsupdown"] = "rbxassetid://10709797508",
    ["chrome"] = "rbxassetid://10709797725",
    ["circle"] = "rbxassetid://10709798174",
    ["circledot"] = "rbxassetid://10709797837",
    ["circleellipsis"] = "rbxassetid://10709797985",
    ["circleslashed"] = "rbxassetid://10709798100",
    ["citrus"] = "rbxassetid://10709798276",
    ["clapperboard"] = "rbxassetid://10709798350",
    ["clipboard"] = "rbxassetid://10709799288",
    ["clipboardcheck"] = "rbxassetid://10709798443",
    ["clipboardcopy"] = "rbxassetid://10709798574",
    ["clipboardedit"] = "rbxassetid://10709798682",
    ["clipboardlist"] = "rbxassetid://10709798792",
    ["clipboardsignature"] = "rbxassetid://10709798890",
    ["clipboardtype"] = "rbxassetid://10709798999",
    ["clipboardx"] = "rbxassetid://10709799124",
    ["clock"] = "rbxassetid://10709805144",
    ["clock1"] = "rbxassetid://10709799535",
    ["clock10"] = "rbxassetid://10709799718",
    ["clock11"] = "rbxassetid://10709799818",
    ["clock12"] = "rbxassetid://10709799962",
    ["clock2"] = "rbxassetid://10709803876",
    ["clock3"] = "rbxassetid://10709803989",
    ["clock4"] = "rbxassetid://10709804164",
    ["clock5"] = "rbxassetid://10709804291",
    ["clock6"] = "rbxassetid://10709804435",
    ["clock7"] = "rbxassetid://10709804599",
    ["clock8"] = "rbxassetid://10709804784",
    ["clock9"] = "rbxassetid://10709804996",
    ["cloud"] = "rbxassetid://10709806740",
    ["cloudcog"] = "rbxassetid://10709805262",
    ["clouddrizzle"] = "rbxassetid://10709805371",
    ["cloudfog"] = "rbxassetid://10709805477",
    ["cloudhail"] = "rbxassetid://10709805596",
    ["cloudlightning"] = "rbxassetid://10709805727",
    ["cloudmoon"] = "rbxassetid://10709805942",
    ["cloudmoonrain"] = "rbxassetid://10709805838",
    ["cloudoff"] = "rbxassetid://10709806060",
    ["cloudrain"] = "rbxassetid://10709806277",
    ["cloudrainwind"] = "rbxassetid://10709806166",
    ["cloudsnow"] = "rbxassetid://10709806374",
    ["cloudsun"] = "rbxassetid://10709806631",
    ["cloudsunrain"] = "rbxassetid://10709806475",
    ["cloudy"] = "rbxassetid://10709806859",
    ["clover"] = "rbxassetid://10709806995",
    ["code"] = "rbxassetid://10709810463",
    ["code2"] = "rbxassetid://10709807111",
    ["codepen"] = "rbxassetid://10709810534",
    ["codesandbox"] = "rbxassetid://10709810676",
    ["coffee"] = "rbxassetid://10709810814",
    ["cog"] = "rbxassetid://10709810948",
    ["coins"] = "rbxassetid://10709811110",
    ["columns"] = "rbxassetid://10709811261",
    ["command"] = "rbxassetid://10709811365",
    ["compass"] = "rbxassetid://10709811445",
    ["component"] = "rbxassetid://10709811595",
    ["conciergebell"] = "rbxassetid://10709811706",
    ["connection"] = "rbxassetid://10747361219",
    ["contact"] = "rbxassetid://10709811834",
    ["contrast"] = "rbxassetid://10709811939",
    ["cookie"] = "rbxassetid://10709812067",
    ["copy"] = "rbxassetid://10709812159",
    ["copyleft"] = "rbxassetid://10709812251",
    ["copyright"] = "rbxassetid://10709812311",
    ["cornerdownleft"] = "rbxassetid://10709812396",
    ["cornerdownright"] = "rbxassetid://10709812485",
    ["cornerleftdown"] = "rbxassetid://10709812632",
    ["cornerleftup"] = "rbxassetid://10709812784",
    ["cornerrightdown"] = "rbxassetid://10709812939",
    ["cornerrightup"] = "rbxassetid://10709813094",
    ["cornerupleft"] = "rbxassetid://10709813185",
    ["cornerupright"] = "rbxassetid://10709813281",
    ["cpu"] = "rbxassetid://10709813383",
    ["croissant"] = "rbxassetid://10709818125",
    ["crop"] = "rbxassetid://10709818245",
    ["cross"] = "rbxassetid://10709818399",
    ["crosshair"] = "rbxassetid://10709818534",
    ["crown"] = "rbxassetid://10709818626",
    ["cupsoda"] = "rbxassetid://10709818763",
    ["curlybraces"] = "rbxassetid://10709818847",
    ["currency"] = "rbxassetid://10709818931",
    ["database"] = "rbxassetid://10709818996",
    ["delete"] = "rbxassetid://10709819059",
    ["diamond"] = "rbxassetid://10709819149",
    ["dice1"] = "rbxassetid://10709819266",
    ["dice2"] = "rbxassetid://10709819361",
    ["dice3"] = "rbxassetid://10709819508",
    ["dice4"] = "rbxassetid://10709819670",
    ["dice5"] = "rbxassetid://10709819801",
    ["dice6"] = "rbxassetid://10709819896",
    ["dices"] = "rbxassetid://10723343321",
    ["diff"] = "rbxassetid://10723343416",
    ["disc"] = "rbxassetid://10723343537",
    ["divide"] = "rbxassetid://10723343805",
    ["dividecircle"] = "rbxassetid://10723343636",
    ["dividesquare"] = "rbxassetid://10723343737",
    ["dollarsign"] = "rbxassetid://10723343958",
    ["download"] = "rbxassetid://10723344270",
    ["downloadcloud"] = "rbxassetid://10723344088",
    ["droplet"] = "rbxassetid://10723344432",
    ["droplets"] = "rbxassetid://10734883356",
    ["drumstick"] = "rbxassetid://10723344737",
    ["edit"] = "rbxassetid://10734883598",
    ["edit2"] = "rbxassetid://10723344885",
    ["edit3"] = "rbxassetid://10723345088",
    ["egg"] = "rbxassetid://10723345518",
    ["eggfried"] = "rbxassetid://10723345347",
    ["electricity"] = "rbxassetid://10723345749",
    ["electricityoff"] = "rbxassetid://10723345643",
    ["equal"] = "rbxassetid://10723345990",
    ["equalnot"] = "rbxassetid://10723345866",
    ["eraser"] = "rbxassetid://10723346158",
    ["euro"] = "rbxassetid://10723346372",
    ["expand"] = "rbxassetid://10723346553",
    ["externallink"] = "rbxassetid://10723346684",
    ["eye"] = "rbxassetid://10723346959",
    ["eyeoff"] = "rbxassetid://10723346871",
    ["factory"] = "rbxassetid://10723347051",
    ["fan"] = "rbxassetid://10723354359",
    ["fastforward"] = "rbxassetid://10723354521",
    ["feather"] = "rbxassetid://10723354671",
    ["figma"] = "rbxassetid://10723354801",
    ["file"] = "rbxassetid://10723374641",
    ["filearchive"] = "rbxassetid://10723354921",
    ["fileaudio"] = "rbxassetid://10723355148",
    ["fileaudio2"] = "rbxassetid://10723355026",
    ["fileaxis3d"] = "rbxassetid://10723355272",
    ["filebadge"] = "rbxassetid://10723355622",
    ["filebadge2"] = "rbxassetid://10723355451",
    ["filebarchart"] = "rbxassetid://10723355887",
    ["filebarchart2"] = "rbxassetid://10723355746",
    ["filebox"] = "rbxassetid://10723355989",
    ["filecheck"] = "rbxassetid://10723356210",
    ["filecheck2"] = "rbxassetid://10723356100",
    ["fileclock"] = "rbxassetid://10723356329",
    ["filecode"] = "rbxassetid://10723356507",
    ["filecog"] = "rbxassetid://10723356830",
    ["filecog2"] = "rbxassetid://10723356676",
    ["filediff"] = "rbxassetid://10723357039",
    ["filedigit"] = "rbxassetid://10723357151",
    ["filedown"] = "rbxassetid://10723357322",
    ["fileedit"] = "rbxassetid://10723357495",
    ["fileheart"] = "rbxassetid://10723357637",
    ["fileimage"] = "rbxassetid://10723357790",
    ["fileinput"] = "rbxassetid://10723357933",
    ["filejson"] = "rbxassetid://10723364435",
    ["filejson2"] = "rbxassetid://10723364361",
    ["filekey"] = "rbxassetid://10723364605",
    ["filekey2"] = "rbxassetid://10723364515",
    ["filelinechart"] = "rbxassetid://10723364725",
    ["filelock"] = "rbxassetid://10723364957",
    ["filelock2"] = "rbxassetid://10723364861",
    ["fileminus"] = "rbxassetid://10723365254",
    ["fileminus2"] = "rbxassetid://10723365086",
    ["fileoutput"] = "rbxassetid://10723365457",
    ["filepiechart"] = "rbxassetid://10723365598",
    ["fileplus"] = "rbxassetid://10723365877",
    ["fileplus2"] = "rbxassetid://10723365766",
    ["filequestion"] = "rbxassetid://10723365987",
    ["filescan"] = "rbxassetid://10723366167",
    ["filesearch"] = "rbxassetid://10723366550",
    ["filesearch2"] = "rbxassetid://10723366340",
    ["filesignature"] = "rbxassetid://10723366741",
    ["filespreadsheet"] = "rbxassetid://10723366962",
    ["filesymlink"] = "rbxassetid://10723367098",
    ["fileterminal"] = "rbxassetid://10723367244",
    ["filetext"] = "rbxassetid://10723367380",
    ["filetype"] = "rbxassetid://10723367606",
    ["filetype2"] = "rbxassetid://10723367509",
    ["fileup"] = "rbxassetid://10723367734",
    ["filevideo"] = "rbxassetid://10723373884",
    ["filevideo2"] = "rbxassetid://10723367834",
    ["filevolume"] = "rbxassetid://10723374172",
    ["filevolume2"] = "rbxassetid://10723374030",
    ["filewarning"] = "rbxassetid://10723374276",
    ["filex"] = "rbxassetid://10723374544",
    ["filex2"] = "rbxassetid://10723374378",
    ["files"] = "rbxassetid://10723374759",
    ["film"] = "rbxassetid://10723374981",
    ["filter"] = "rbxassetid://10723375128",
    ["fingerprint"] = "rbxassetid://10723375250",
    ["flag"] = "rbxassetid://10723375890",
    ["flagoff"] = "rbxassetid://10723375443",
    ["flagtriangleleft"] = "rbxassetid://10723375608",
    ["flagtriangleright"] = "rbxassetid://10723375727",
    ["flame"] = "rbxassetid://10723376114",
    ["flashlight"] = "rbxassetid://10723376471",
    ["flashlightoff"] = "rbxassetid://10723376365",
    ["flaskconical"] = "rbxassetid://10734883986",
    ["flaskround"] = "rbxassetid://10723376614",
    ["fliphorizontal"] = "rbxassetid://10723376884",
    ["fliphorizontal2"] = "rbxassetid://10723376745",
    ["flipvertical"] = "rbxassetid://10723377138",
    ["flipvertical2"] = "rbxassetid://10723377026",
    ["flower"] = "rbxassetid://10747830374",
    ["flower2"] = "rbxassetid://10723377305",
    ["focus"] = "rbxassetid://10723377537",
    ["folder"] = "rbxassetid://10723387563",
    ["folderarchive"] = "rbxassetid://10723384478",
    ["foldercheck"] = "rbxassetid://10723384605",
    ["folderclock"] = "rbxassetid://10723384731",
    ["folderclosed"] = "rbxassetid://10723384893",
    ["foldercog"] = "rbxassetid://10723385213",
    ["foldercog2"] = "rbxassetid://10723385036",
    ["folderdown"] = "rbxassetid://10723385338",
    ["folderedit"] = "rbxassetid://10723385445",
    ["folderheart"] = "rbxassetid://10723385545",
    ["folderinput"] = "rbxassetid://10723385721",
    ["folderkey"] = "rbxassetid://10723385848",
    ["folderlock"] = "rbxassetid://10723386005",
    ["folderminus"] = "rbxassetid://10723386127",
    ["folderopen"] = "rbxassetid://10723386277",
    ["folderoutput"] = "rbxassetid://10723386386",
    ["folderplus"] = "rbxassetid://10723386531",
    ["foldersearch"] = "rbxassetid://10723386787",
    ["foldersearch2"] = "rbxassetid://10723386674",
    ["foldersymlink"] = "rbxassetid://10723386930",
    ["foldertree"] = "rbxassetid://10723387085",
    ["folderup"] = "rbxassetid://10723387265",
    ["folderx"] = "rbxassetid://10723387448",
    ["folders"] = "rbxassetid://10723387721",
    ["forminput"] = "rbxassetid://10723387841",
    ["forward"] = "rbxassetid://10723388016",
    ["frame"] = "rbxassetid://10723394389",
    ["framer"] = "rbxassetid://10723394565",
    ["frown"] = "rbxassetid://10723394681",
    ["fuel"] = "rbxassetid://10723394846",
    ["functionsquare"] = "rbxassetid://10723395041",
    ["gamepad"] = "rbxassetid://10723395457",
    ["gamepad2"] = "rbxassetid://10723395215",
    ["gauge"] = "rbxassetid://10723395708",
    ["gavel"] = "rbxassetid://10723395896",
    ["gem"] = "rbxassetid://10723396000",
    ["ghost"] = "rbxassetid://10723396107",
    ["gift"] = "rbxassetid://10723396402",
    ["giftcard"] = "rbxassetid://10723396225",
    ["gitbranch"] = "rbxassetid://10723396676",
    ["gitbranchplus"] = "rbxassetid://10723396542",
    ["gitcommit"] = "rbxassetid://10723396812",
    ["gitcompare"] = "rbxassetid://10723396954",
    ["gitfork"] = "rbxassetid://10723397049",
    ["gitmerge"] = "rbxassetid://10723397165",
    ["gitpullrequest"] = "rbxassetid://10723397431",
    ["gitpullrequestclosed"] = "rbxassetid://10723397268",
    ["gitpullrequestdraft"] = "rbxassetid://10734884302",
    ["glass"] = "rbxassetid://10723397788",
    ["glass2"] = "rbxassetid://10723397529",
    ["glasswater"] = "rbxassetid://10723397678",
    ["glasses"] = "rbxassetid://10723397895",
    ["globe"] = "rbxassetid://10723404337",
    ["globe2"] = "rbxassetid://10723398002",
    ["grab"] = "rbxassetid://10723404472",
    ["graduationcap"] = "rbxassetid://10723404691",
    ["grape"] = "rbxassetid://10723404822",
    ["grid"] = "rbxassetid://10723404936",
    ["griphorizontal"] = "rbxassetid://10723405089",
    ["gripvertical"] = "rbxassetid://10723405236",
    ["hammer"] = "rbxassetid://10723405360",
    ["hand"] = "rbxassetid://10723405649",
    ["handmetal"] = "rbxassetid://10723405508",
    ["harddrive"] = "rbxassetid://10723405749",
    ["hardhat"] = "rbxassetid://10723405859",
    ["hash"] = "rbxassetid://10723405975",
    ["haze"] = "rbxassetid://10723406078",
    ["headphones"] = "rbxassetid://10723406165",
    ["heart"] = "rbxassetid://10723406885",
    ["heartcrack"] = "rbxassetid://10723406299",
    ["hearthandshake"] = "rbxassetid://10723406480",
    ["heartoff"] = "rbxassetid://10723406662",
    ["heartpulse"] = "rbxassetid://10723406795",
    ["helpcircle"] = "rbxassetid://10723406988",
    ["hexagon"] = "rbxassetid://10723407092",
    ["highlighter"] = "rbxassetid://10723407192",
    ["history"] = "rbxassetid://10723407335",
    ["home"] = "rbxassetid://10723407389",
    ["hourglass"] = "rbxassetid://10723407498",
    ["icecream"] = "rbxassetid://10723414308",
    ["image"] = "rbxassetid://10723415040",
    ["imageminus"] = "rbxassetid://10723414487",
    ["imageoff"] = "rbxassetid://10723414677",
    ["imageplus"] = "rbxassetid://10723414827",
    ["import"] = "rbxassetid://10723415205",
    ["inbox"] = "rbxassetid://10723415335",
    ["indent"] = "rbxassetid://10723415494",
    ["indianrupee"] = "rbxassetid://10723415642",
    ["infinity"] = "rbxassetid://10723415766",
    ["info"] = "rbxassetid://10723415903",
    ["inspect"] = "rbxassetid://10723416057",
    ["italic"] = "rbxassetid://10723416195",
    ["japaneseyen"] = "rbxassetid://10723416363",
    ["joystick"] = "rbxassetid://10723416527",
    ["key"] = "rbxassetid://10723416652",
    ["keyboard"] = "rbxassetid://10723416765",
    ["lamp"] = "rbxassetid://10723417513",
    ["lampceiling"] = "rbxassetid://10723416922",
    ["lampdesk"] = "rbxassetid://10723417016",
    ["lampfloor"] = "rbxassetid://10723417131",
    ["lampwalldown"] = "rbxassetid://10723417240",
    ["lampwallup"] = "rbxassetid://10723417356",
    ["landmark"] = "rbxassetid://10723417608",
    ["languages"] = "rbxassetid://10723417703",
    ["laptop"] = "rbxassetid://10723423881",
    ["laptop2"] = "rbxassetid://10723417797",
    ["lasso"] = "rbxassetid://10723424235",
    ["lassoselect"] = "rbxassetid://10723424058",
    ["laugh"] = "rbxassetid://10723424372",
    ["layers"] = "rbxassetid://10723424505",
    ["layout"] = "rbxassetid://10723425376",
    ["layoutdashboard"] = "rbxassetid://10723424646",
    ["layoutgrid"] = "rbxassetid://10723424838",
    ["layoutlist"] = "rbxassetid://10723424963",
    ["layouttemplate"] = "rbxassetid://10723425187",
    ["leaf"] = "rbxassetid://10723425539",
    ["library"] = "rbxassetid://10723425615",
    ["lifebuoy"] = "rbxassetid://10723425685",
    ["lightbulb"] = "rbxassetid://10723425852",
    ["lightbulboff"] = "rbxassetid://10723425762",
    ["linechart"] = "rbxassetid://10723426393",
    ["link"] = "rbxassetid://10723426722",
    ["link2"] = "rbxassetid://10723426595",
    ["link2off"] = "rbxassetid://10723426513",
    ["list"] = "rbxassetid://10723433811",
    ["listchecks"] = "rbxassetid://10734884548",
    ["listend"] = "rbxassetid://10723426886",
    ["listminus"] = "rbxassetid://10723426986",
    ["listmusic"] = "rbxassetid://10723427081",
    ["listordered"] = "rbxassetid://10723427199",
    ["listplus"] = "rbxassetid://10723427334",
    ["liststart"] = "rbxassetid://10723427494",
    ["listvideo"] = "rbxassetid://10723427619",
    ["listx"] = "rbxassetid://10723433655",
    ["loader"] = "rbxassetid://10723434070",
    ["loader2"] = "rbxassetid://10723433935",
    ["locate"] = "rbxassetid://10723434557",
    ["locatefixed"] = "rbxassetid://10723434236",
    ["locateoff"] = "rbxassetid://10723434379",
    ["lock"] = "rbxassetid://10723434711",
    ["login"] = "rbxassetid://10723434830",
    ["logout"] = "rbxassetid://10723434906",
    ["luggage"] = "rbxassetid://10723434993",
    ["magnet"] = "rbxassetid://10723435069",
    ["mail"] = "rbxassetid://10734885430",
    ["mailcheck"] = "rbxassetid://10723435182",
    ["mailminus"] = "rbxassetid://10723435261",
    ["mailopen"] = "rbxassetid://10723435342",
    ["mailplus"] = "rbxassetid://10723435443",
    ["mailquestion"] = "rbxassetid://10723435515",
    ["mailsearch"] = "rbxassetid://10734884739",
    ["mailwarning"] = "rbxassetid://10734885015",
    ["mailx"] = "rbxassetid://10734885247",
    ["mails"] = "rbxassetid://10734885614",
    ["map"] = "rbxassetid://10734886202",
    ["mappin"] = "rbxassetid://10734886004",
    ["mappinoff"] = "rbxassetid://10734885803",
    ["maximize"] = "rbxassetid://10734886735",
    ["maximize2"] = "rbxassetid://10734886496",
    ["medal"] = "rbxassetid://10734887072",
    ["megaphone"] = "rbxassetid://10734887454",
    ["megaphoneoff"] = "rbxassetid://10734887311",
    ["meh"] = "rbxassetid://10734887603",
    ["menu"] = "rbxassetid://10734887784",
    ["messagecircle"] = "rbxassetid://10734888000",
    ["messagesquare"] = "rbxassetid://10734888228",
    ["mic"] = "rbxassetid://10734888864",
    ["mic2"] = "rbxassetid://10734888430",
    ["micoff"] = "rbxassetid://10734888646",
    ["microscope"] = "rbxassetid://10734889106",
    ["microwave"] = "rbxassetid://10734895076",
    ["milestone"] = "rbxassetid://10734895310",
    ["minimize"] = "rbxassetid://10734895698",
    ["minimize2"] = "rbxassetid://10734895530",
    ["minus"] = "rbxassetid://10734896206",
    ["minuscircle"] = "rbxassetid://10734895856",
    ["minussquare"] = "rbxassetid://10734896029",
    ["monitor"] = "rbxassetid://10734896881",
    ["monitoroff"] = "rbxassetid://10734896360",
    ["monitorspeaker"] = "rbxassetid://10734896512",
    ["moon"] = "rbxassetid://10734897102",
    ["morehorizontal"] = "rbxassetid://10734897250",
    ["morevertical"] = "rbxassetid://10734897387",
    ["mountain"] = "rbxassetid://10734897956",
    ["mountainsnow"] = "rbxassetid://10734897665",
    ["mouse"] = "rbxassetid://10734898592",
    ["mousepointer"] = "rbxassetid://10734898476",
    ["mousepointer2"] = "rbxassetid://10734898194",
    ["mousepointerclick"] = "rbxassetid://10734898355",
    ["move"] = "rbxassetid://10734900011",
    ["move3d"] = "rbxassetid://10734898756",
    ["movediagonal"] = "rbxassetid://10734899164",
    ["movediagonal2"] = "rbxassetid://10734898934",
    ["movehorizontal"] = "rbxassetid://10734899414",
    ["movevertical"] = "rbxassetid://10734899821",
    ["music"] = "rbxassetid://10734905958",
    ["music2"] = "rbxassetid://10734900215",
    ["music3"] = "rbxassetid://10734905665",
    ["music4"] = "rbxassetid://10734905823",
    ["navigation"] = "rbxassetid://10734906744",
    ["navigation2"] = "rbxassetid://10734906332",
    ["navigation2off"] = "rbxassetid://10734906144",
    ["navigationoff"] = "rbxassetid://10734906580",
    ["network"] = "rbxassetid://10734906975",
    ["newspaper"] = "rbxassetid://10734907168",
    ["octagon"] = "rbxassetid://10734907361",
    ["option"] = "rbxassetid://10734907649",
    ["outdent"] = "rbxassetid://10734907933",
    ["package"] = "rbxassetid://10734909540",
    ["package2"] = "rbxassetid://10734908151",
    ["packagecheck"] = "rbxassetid://10734908384",
    ["packageminus"] = "rbxassetid://10734908626",
    ["packageopen"] = "rbxassetid://10734908793",
    ["packageplus"] = "rbxassetid://10734909016",
    ["packagesearch"] = "rbxassetid://10734909196",
    ["packagex"] = "rbxassetid://10734909375",
    ["paintbucket"] = "rbxassetid://10734909847",
    ["paintbrush"] = "rbxassetid://10734910187",
    ["paintbrush2"] = "rbxassetid://10734910030",
    ["palette"] = "rbxassetid://10734910430",
    ["palmtree"] = "rbxassetid://10734910680",
    ["paperclip"] = "rbxassetid://10734910927",
    ["partypopper"] = "rbxassetid://10734918735",
    ["pause"] = "rbxassetid://10734919336",
    ["pausecircle"] = "rbxassetid://10735024209",
    ["pauseoctagon"] = "rbxassetid://10734919143",
    ["pentool"] = "rbxassetid://10734919503",
    ["pencil"] = "rbxassetid://10734919691",
    ["percent"] = "rbxassetid://10734919919",
    ["personstanding"] = "rbxassetid://10734920149",
    ["phone"] = "rbxassetid://10734921524",
    ["phonecall"] = "rbxassetid://10734920305",
    ["phoneforwarded"] = "rbxassetid://10734920508",
    ["phoneincoming"] = "rbxassetid://10734920694",
    ["phonemissed"] = "rbxassetid://10734920845",
    ["phoneoff"] = "rbxassetid://10734921077",
    ["phoneoutgoing"] = "rbxassetid://10734921288",
    ["piechart"] = "rbxassetid://10734921727",
    ["piggybank"] = "rbxassetid://10734921935",
    ["pin"] = "rbxassetid://10734922324",
    ["pinoff"] = "rbxassetid://10734922180",
    ["pipette"] = "rbxassetid://10734922497",
    ["pizza"] = "rbxassetid://10734922774",
    ["plane"] = "rbxassetid://10734922971",
    ["play"] = "rbxassetid://10734923549",
    ["playcircle"] = "rbxassetid://10734923214",
    ["plus"] = "rbxassetid://10734924532",
    ["pluscircle"] = "rbxassetid://10734923868",
    ["plussquare"] = "rbxassetid://10734924219",
    ["podcast"] = "rbxassetid://10734929553",
    ["pointer"] = "rbxassetid://10734929723",
    ["poundsterling"] = "rbxassetid://10734929981",
    ["power"] = "rbxassetid://10734930466",
    ["poweroff"] = "rbxassetid://10734930257",
    ["printer"] = "rbxassetid://10734930632",
    ["puzzle"] = "rbxassetid://10734930886",
    ["quote"] = "rbxassetid://10734931234",
    ["radio"] = "rbxassetid://10734931596",
    ["radioreceiver"] = "rbxassetid://10734931402",
    ["rectanglehorizontal"] = "rbxassetid://10734931777",
    ["rectanglevertical"] = "rbxassetid://10734932081",
    ["recycle"] = "rbxassetid://10734932295",
    ["redo"] = "rbxassetid://10734932822",
    ["redo2"] = "rbxassetid://10734932586",
    ["refreshccw"] = "rbxassetid://10734933056",
    ["refreshcw"] = "rbxassetid://10734933222",
    ["refrigerator"] = "rbxassetid://10734933465",
    ["regex"] = "rbxassetid://10734933655",
    ["repeat"] = "rbxassetid://10734933966",
    ["repeat1"] = "rbxassetid://10734933826",
    ["reply"] = "rbxassetid://10734934252",
    ["replyall"] = "rbxassetid://10734934132",
    ["rewind"] = "rbxassetid://10734934347",
    ["rocket"] = "rbxassetid://10734934585",
    ["rockingchair"] = "rbxassetid://10734939942",
    ["rotate3d"] = "rbxassetid://10734940107",
    ["rotateccw"] = "rbxassetid://10734940376",
    ["rotatecw"] = "rbxassetid://10734940654",
    ["rss"] = "rbxassetid://10734940825",
    ["ruler"] = "rbxassetid://10734941018",
    ["russianruble"] = "rbxassetid://10734941199",
    ["sailboat"] = "rbxassetid://10734941354",
    ["save"] = "rbxassetid://10734941499",
    ["scale"] = "rbxassetid://10734941912",
    ["scale3d"] = "rbxassetid://10734941739",
    ["scaling"] = "rbxassetid://10734942072",
    ["scan"] = "rbxassetid://10734942565",
    ["scanface"] = "rbxassetid://10734942198",
    ["scanline"] = "rbxassetid://10734942351",
    ["scissors"] = "rbxassetid://10734942778",
    ["screenshare"] = "rbxassetid://10734943193",
    ["screenshareoff"] = "rbxassetid://10734942967",
    ["scroll"] = "rbxassetid://10734943448",
    ["search"] = "rbxassetid://10734943674",
    ["send"] = "rbxassetid://10734943902",
    ["separatorhorizontal"] = "rbxassetid://10734944115",
    ["separatorvertical"] = "rbxassetid://10734944326",
    ["server"] = "rbxassetid://10734949856",
    ["servercog"] = "rbxassetid://10734944444",
    ["servercrash"] = "rbxassetid://10734944554",
    ["serveroff"] = "rbxassetid://10734944668",
    ["settings"] = "rbxassetid://10734950309",
    ["settings2"] = "rbxassetid://10734950020",
    ["share"] = "rbxassetid://10734950813",
    ["share2"] = "rbxassetid://10734950553",
    ["sheet"] = "rbxassetid://10734951038",
    ["shield"] = "rbxassetid://10734951847",
    ["shieldalert"] = "rbxassetid://10734951173",
    ["shieldcheck"] = "rbxassetid://10734951367",
    ["shieldclose"] = "rbxassetid://10734951535",
    ["shieldoff"] = "rbxassetid://10734951684",
    ["shirt"] = "rbxassetid://10734952036",
    ["shoppingbag"] = "rbxassetid://10734952273",
    ["shoppingcart"] = "rbxassetid://10734952479",
    ["shovel"] = "rbxassetid://10734952773",
    ["showerhead"] = "rbxassetid://10734952942",
    ["shrink"] = "rbxassetid://10734953073",
    ["shrub"] = "rbxassetid://10734953241",
    ["shuffle"] = "rbxassetid://10734953451",
    ["sidebar"] = "rbxassetid://10734954301",
    ["sidebarclose"] = "rbxassetid://10734953715",
    ["sidebaropen"] = "rbxassetid://10734954000",
    ["sigma"] = "rbxassetid://10734954538",
    ["signal"] = "rbxassetid://10734961133",
    ["signalhigh"] = "rbxassetid://10734954807",
    ["signallow"] = "rbxassetid://10734955080",
    ["signalmedium"] = "rbxassetid://10734955336",
    ["signalzero"] = "rbxassetid://10734960878",
    ["siren"] = "rbxassetid://10734961284",
    ["skipback"] = "rbxassetid://10734961526",
    ["skipforward"] = "rbxassetid://10734961809",
    ["skull"] = "rbxassetid://10734962068",
    ["slack"] = "rbxassetid://10734962339",
    ["slash"] = "rbxassetid://10734962600",
    ["slice"] = "rbxassetid://10734963024",
    ["sliders"] = "rbxassetid://10734963400",
    ["slidershorizontal"] = "rbxassetid://10734963191",
    ["smartphone"] = "rbxassetid://10734963940",
    ["smartphonecharging"] = "rbxassetid://10734963671",
    ["smile"] = "rbxassetid://10734964441",
    ["smileplus"] = "rbxassetid://10734964188",
    ["snowflake"] = "rbxassetid://10734964600",
    ["sofa"] = "rbxassetid://10734964852",
    ["sortasc"] = "rbxassetid://10734965115",
    ["sortdesc"] = "rbxassetid://10734965287",
    ["speaker"] = "rbxassetid://10734965419",
    ["sprout"] = "rbxassetid://10734965572",
    ["square"] = "rbxassetid://10734965702",
    ["star"] = "rbxassetid://10734966248",
    ["starhalf"] = "rbxassetid://10734965897",
    ["staroff"] = "rbxassetid://10734966097",
    ["stethoscope"] = "rbxassetid://10734966384",
    ["sticker"] = "rbxassetid://10734972234",
    ["stickynote"] = "rbxassetid://10734972463",
    ["stopcircle"] = "rbxassetid://10734972621",
    ["stretchhorizontal"] = "rbxassetid://10734972862",
    ["stretchvertical"] = "rbxassetid://10734973130",
    ["strikethrough"] = "rbxassetid://10734973290",
    ["subscript"] = "rbxassetid://10734973457",
    ["sun"] = "rbxassetid://10734974297",
    ["sundim"] = "rbxassetid://10734973645",
    ["sunmedium"] = "rbxassetid://10734973778",
    ["sunmoon"] = "rbxassetid://10734973999",
    ["sunsnow"] = "rbxassetid://10734974130",
    ["sunrise"] = "rbxassetid://10734974522",
    ["sunset"] = "rbxassetid://10734974689",
    ["superscript"] = "rbxassetid://10734974850",
    ["swissfranc"] = "rbxassetid://10734975024",
    ["switchcamera"] = "rbxassetid://10734975214",
    ["sword"] = "rbxassetid://10734975486",
    ["swords"] = "rbxassetid://10734975692",
    ["syringe"] = "rbxassetid://10734975932",
    ["table"] = "rbxassetid://10734976230",
    ["table2"] = "rbxassetid://10734976097",
    ["tablet"] = "rbxassetid://10734976394",
    ["tag"] = "rbxassetid://10734976528",
    ["tags"] = "rbxassetid://10734976739",
    ["target"] = "rbxassetid://10734977012",
    ["tent"] = "rbxassetid://10734981750",
    ["terminal"] = "rbxassetid://10734982144",
    ["terminalsquare"] = "rbxassetid://10734981995",
    ["textcursor"] = "rbxassetid://10734982395",
    ["textcursorinput"] = "rbxassetid://10734982297",
    ["thermometer"] = "rbxassetid://10734983134",
    ["thermometersnowflake"] = "rbxassetid://10734982571",
    ["thermometersun"] = "rbxassetid://10734982771",
    ["thumbsdown"] = "rbxassetid://10734983359",
    ["thumbsup"] = "rbxassetid://10734983629",
    ["ticket"] = "rbxassetid://10734983868",
    ["timer"] = "rbxassetid://10734984606",
    ["timeroff"] = "rbxassetid://10734984138",
    ["timerreset"] = "rbxassetid://10734984355",
    ["toggleleft"] = "rbxassetid://10734984834",
    ["toggleright"] = "rbxassetid://10734985040",
    ["tornado"] = "rbxassetid://10734985247",
    ["toybrick"] = "rbxassetid://10747361919",
    ["train"] = "rbxassetid://10747362105",
    ["trash"] = "rbxassetid://10747362393",
    ["trash2"] = "rbxassetid://10747362241",
    ["treedeciduous"] = "rbxassetid://10747362534",
    ["treepine"] = "rbxassetid://10747362748",
    ["trees"] = "rbxassetid://10747363016",
    ["trendingdown"] = "rbxassetid://10747363205",
    ["trendingup"] = "rbxassetid://10747363465",
    ["triangle"] = "rbxassetid://10747363621",
    ["trophy"] = "rbxassetid://10747363809",
    ["truck"] = "rbxassetid://10747364031",
    ["tv"] = "rbxassetid://10747364593",
    ["tv2"] = "rbxassetid://10747364302",
    ["type"] = "rbxassetid://10747364761",
    ["umbrella"] = "rbxassetid://10747364971",
    ["underline"] = "rbxassetid://10747365191",
    ["undo"] = "rbxassetid://10747365484",
    ["undo2"] = "rbxassetid://10747365359",
    ["unlink"] = "rbxassetid://10747365771",
    ["unlink2"] = "rbxassetid://10747397871",
    ["unlock"] = "rbxassetid://10747366027",
    ["upload"] = "rbxassetid://10747366434",
    ["uploadcloud"] = "rbxassetid://10747366266",
    ["usb"] = "rbxassetid://10747366606",
    ["user"] = "rbxassetid://10747373176",
    ["usercheck"] = "rbxassetid://10747371901",
    ["usercog"] = "rbxassetid://10747372167",
    ["userminus"] = "rbxassetid://10747372346",
    ["userplus"] = "rbxassetid://10747372702",
    ["userx"] = "rbxassetid://10747372992",
    ["users"] = "rbxassetid://10747373426",
    ["utensils"] = "rbxassetid://10747373821",
    ["utensilscrossed"] = "rbxassetid://10747373629",
    ["venetianmask"] = "rbxassetid://10747374003",
    ["verified"] = "rbxassetid://10747374131",
    ["vibrate"] = "rbxassetid://10747374489",
    ["vibrateoff"] = "rbxassetid://10747374269",
    ["video"] = "rbxassetid://10747374938",
    ["videooff"] = "rbxassetid://10747374721",
    ["view"] = "rbxassetid://10747375132",
    ["voicemail"] = "rbxassetid://10747375281",
    ["volume"] = "rbxassetid://10747376008",
    ["volume1"] = "rbxassetid://10747375450",
    ["volume2"] = "rbxassetid://10747375679",
    ["volumex"] = "rbxassetid://10747375880",
    ["wallet"] = "rbxassetid://10747376205",
    ["wand"] = "rbxassetid://10747376565",
    ["wand2"] = "rbxassetid://10747376349",
    ["watch"] = "rbxassetid://10747376722",
    ["waves"] = "rbxassetid://10747376931",
    ["webcam"] = "rbxassetid://10747381992",
    ["wifi"] = "rbxassetid://10747382504",
    ["wifioff"] = "rbxassetid://10747382268",
    ["wind"] = "rbxassetid://10747382750",
    ["wraptext"] = "rbxassetid://10747383065",
    ["wrench"] = "rbxassetid://10747383470",
    ["x"] = "rbxassetid://10747384394",
    ["xcircle"] = "rbxassetid://10747383819",
    ["xoctagon"] = "rbxassetid://10747384037",
    ["xsquare"] = "rbxassetid://10747384217",
    ["zoomin"] = "rbxassetid://10747384552",
    ["zoomout"] = "rbxassetid://10747384679"
}

-- ============================================================================
-- UTILITY MODULES
-- ============================================================================

-- Janitor Pattern
local Janitor = {}
Janitor.__index = Janitor

function Janitor.new()
    local self = setmetatable({}, Janitor)
    self._objects = {}
    self._connections = {}
    self._callbacks = {}
    return self
end

function Janitor:Add(obj)
    table.insert(self._objects, obj)
    return obj
end

function Janitor:AddConnection(connection)
    table.insert(self._connections, connection)
    return connection
end

function Janitor:AddCallback(callback)
    table.insert(self._callbacks, callback)
    return callback
end

function Janitor:Cleanup()
    for _, obj in ipairs(self._objects) do
        if obj.Destroy then
            pcall(function() obj:Destroy() end)
        end
    end
    for _, conn in ipairs(self._connections) do
        pcall(function() conn:Disconnect() end)
    end
    for _, cb in ipairs(self._callbacks) do
        pcall(cb)
    end
    self._objects = {}
    self._connections = {}
    self._callbacks = {}
end

-- Signal System
local Signal = {}
Signal.__index = Signal

function Signal.new()
    local self = setmetatable({}, Signal)
    self._listeners = {}
    self._onceListeners = {}
    return self
end

function Signal:Connect(callback)
    table.insert(self._listeners, callback)
    local connection = {
        Disconnect = function()
            for i, cb in ipairs(self._listeners) do
                if cb == callback then
                    table.remove(self._listeners, i)
                    break
                end
            end
        end
    }
    return connection
end

function Signal:ConnectOnce(callback)
    table.insert(self._onceListeners, callback)
    local connection = {
        Disconnect = function()
            for i, cb in ipairs(self._onceListeners) do
                if cb == callback then
                    table.remove(self._onceListeners, i)
                    break
                end
            end
        end
    }
    return connection
end

function Signal:Fire(...)
    local listeners = table.clone(self._listeners)
    for _, cb in ipairs(listeners) do
        task.spawn(cb, ...)
    end
    
    local onceListeners = table.clone(self._onceListeners)
    self._onceListeners = {}
    for _, cb in ipairs(onceListeners) do
        task.spawn(cb, ...)
    end
end

function Signal:Destroy()
    self._listeners = {}
    self._onceListeners = {}
end

-- Promise System
local Promise = {}
Promise.__index = Promise

function Promise.new(executor)
    local self = setmetatable({}, Promise)
    self._state = "pending"
    self._value = nil
    self._error = nil
    self._callbacks = {}
    
    local function resolve(value)
        if self._state ~= "pending" then return end
        self._state = "fulfilled"
        self._value = value
        task.spawn(function()
            for _, cb in ipairs(self._callbacks) do
                if cb.type == "then" then
                    pcall(cb.fn, value)
                end
            end
        end)
    end
    
    local function reject(error)
        if self._state ~= "pending" then return end
        self._state = "rejected"
        self._error = error
        task.spawn(function()
            for _, cb in ipairs(self._callbacks) do
                if cb.type == "catch" then
                    pcall(cb.fn, error)
                end
            end
        end)
    end
    
    pcall(executor, resolve, reject)
    return self
end

function Promise:Then(callback)
    if self._state == "fulfilled" then
        task.spawn(callback, self._value)
    elseif self._state == "pending" then
        table.insert(self._callbacks, { type = "then", fn = callback })
    end
    return self
end

function Promise:Catch(callback)
    if self._state == "rejected" then
        task.spawn(callback, self._error)
    elseif self._state == "pending" then
        table.insert(self._callbacks, { type = "catch", fn = callback })
    end
    return self
end

function Promise:Finally(callback)
    if self._state ~= "pending" then
        task.spawn(callback)
    else
        table.insert(self._callbacks, { type = "finally", fn = callback })
    end
    return self
end

Promise.Resolve = function(value)
    return Promise.new(function(resolve) resolve(value) end)
end

Promise.Reject = function(error)
    return Promise.new(function(_, reject) reject(error) end)
end

Promise.All = function(promises)
    return Promise.new(function(resolve, reject)
        local results = {}
        local completed = 0
        for i, promise in ipairs(promises) do
            promise:Then(function(value)
                results[i] = value
                completed = completed + 1
                if completed == #promises then
                    resolve(results)
                end
            end):Catch(reject)
        end
    end)
end

-- Color Utilities
local Color = {}

function Color.fromRGB(r, g, b)
    return Color3.fromRGB(r, g, b)
end

function Color.fromHex(hex)
    hex = hex:gsub("#", "")
    local r = tonumber(hex:sub(1, 2), 16) or 0
    local g = tonumber(hex:sub(3, 4), 16) or 0
    local b = tonumber(hex:sub(5, 6), 16) or 0
    return Color3.fromRGB(r, g, b)
end

function Color.toHex(color)
    local r = math.floor(color.R * 255)
    local g = math.floor(color.G * 255)
    local b = math.floor(color.B * 255)
    return string.format("#%02x%02x%02x", r, g, b)
end

function Color.lerp(a, b, t)
    return Color3.new(
        a.R + (b.R - a.R) * t,
        a.G + (b.G - a.G) * t,
        a.B + (b.B - a.B) * t
    )
end

-- Tween System
local Tween = {}

function Tween:Create(object, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(
        duration or 0.3,
        style or Enum.EasingStyle.Quart,
        direction or Enum.EasingDirection.Out
    )
    return game:GetService("TweenService"):Create(object, tweenInfo, properties)
end

function Tween:Play(tween)
    tween:Play()
    return tween
end

function Tween:Promise(object, properties, duration, style, direction)
    return Promise.new(function(resolve)
        local tween = self:Create(object, properties, duration, style, direction)
        tween:Play()
        tween.Completed:Connect(resolve)
    end)
end

-- ============================================================================
-- ENHANCED TAB CLASS WITH ICONS
-- ============================================================================

local Tab = {}
Tab.__index = Tab

function Tab.new(name, icon, parent, options)
    local self = setmetatable({}, Tab)
    self.Name = name
    self.Icon = icon or ""
    self.Parent = parent
    self.Container = nil
    self.Button = nil
    self.Content = nil
    self.Sections = {}
    self.Visible = true
    self.Badge = nil
    self.NotificationDot = false
    self.NotificationCount = 0
    self.Options = options or {}
    self.IsSelected = false
    return self
end

function Tab:CreateUI(tabContainer, contentContainer)
    -- Create tab button with enhanced design
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 42)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    button.BackgroundTransparency = 0.5
    button.Text = ""
    button.BorderSizePixel = 0
    button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    button.Parent = tabContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Icon
    local iconLabel = nil
    if self.Icon and self.Icon ~= "" then
        iconLabel = Instance.new("ImageLabel")
        iconLabel.Size = UDim2.new(0, 20, 0, 20)
        iconLabel.Position = UDim2.new(0, 10, 0.5, -10)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Image = self.Icon
        iconLabel.Parent = button
    end
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -40, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Name
    label.TextSize = 13
    label.TextColor3 = Color3.fromRGB(160, 160, 170)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    label.Parent = button
    
    -- Badge (if any)
    if self.Badge and self.Badge ~= "" then
        local badge = Instance.new("Frame")
        badge.Size = UDim2.new(0, 20, 0, 20)
        badge.Position = UDim2.new(1, -30, 0.5, -10)
        badge.BackgroundColor3 = Color3.fromRGB(98, 0, 238)
        badge.BorderSizePixel = 0
        badge.Parent = button
        
        local badgeCorner = Instance.new("UICorner")
        badgeCorner.CornerRadius = UDim.new(1, 0)
        badgeCorner.Parent = badge
        
        local badgeText = Instance.new("TextLabel")
        badgeText.Size = UDim2.new(1, 0, 1, 0)
        badgeText.BackgroundTransparency = 1
        badgeText.Text = self.Badge
        badgeText.TextSize = 10
        badgeText.TextColor3 = Color3.fromRGB(255, 255, 255)
        badgeText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        badgeText.Parent = badge
    end
    
    -- Notification dot
    if self.NotificationDot then
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 8, 0, 8)
        dot.Position = UDim2.new(1, -15, 0, 5)
        dot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        dot.BorderSizePixel = 0
        dot.Parent = button
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = dot
    end
    
    -- Create content frame for this tab
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.Parent = contentContainer
    content.Visible = false
    
    -- Store references
    self.Button = button
    self.Label = label
    self.IconLabel = iconLabel
    self.Content = content
    self.Corner = corner
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        if not self.IsSelected then
            button.BackgroundTransparency = 0.3
        end
    end)
    
    button.MouseLeave:Connect(function()
        if not self.IsSelected then
            button.BackgroundTransparency = 0.5
        end
    end)
    
    -- Click handler
    button.MouseButton1Click:Connect(function()
        if self.Parent then
            self.Parent:SelectTab(self)
        end
    end)
    
    return button
end

function Tab:Select()
    self.IsSelected = true
    if self.Button then
        self.Button.BackgroundTransparency = 0
        self.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        if self.Label then
            self.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    if self.Content then
        self.Content.Visible = true
    end
end

function Tab:Deselect()
    self.IsSelected = false
    if self.Button then
        self.Button.BackgroundTransparency = 0.5
        self.Button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        if self.Label then
            self.Label.TextColor3 = Color3.fromRGB(160, 160, 170)
        end
    end
    if self.Content then
        self.Content.Visible = false
    end
end

function Tab:SetName(name)
    self.Name = name
    if self.Label then
        self.Label.Text = name
    end
end

function Tab:SetIcon(icon)
    self.Icon = icon
    if self.IconLabel then
        self.IconLabel.Image = icon
    end
end

function Tab:SetBadge(text)
    self.Badge = text
    -- Update badge if exists
end

function Tab:ShowNotification()
    self.NotificationDot = true
    -- Add dot if not exists
end

function Tab:HideNotification()
    self.NotificationDot = false
    -- Remove dot if exists
end

function Tab:Show()
    self.Visible = true
    if self.Button then
        self.Button.Visible = true
    end
    if self.Content then
        self.Content.Visible = self.IsSelected
    end
end

function Tab:Hide()
    self.Visible = false
    if self.Button then
        self.Button.Visible = false
    end
    if self.Content then
        self.Content.Visible = false
    end
end

function Tab:Destroy()
    if self.Button then
        self.Button:Destroy()
    end
    if self.Content then
        self.Content:Destroy()
    end
end

-- ============================================================================
-- ENHANCED WINDOW CLASS
-- ============================================================================

local Window = {}
Window.__index = Window

function Window.new(options)
    local self = setmetatable({}, Window)
    
    -- Properties
    self.Title = options.Title or "Lumina"
    self.SubTitle = options.SubTitle or ""
    self.Icon = options.Icon or ""
    self.Theme = options.Theme or "Dark"
    self.Accent = options.Accent or Color3.fromRGB(98, 0, 238)
    self.SaveFolder = options.SaveFolder or "LuminaConfig.json"
    self.Size = options.Size or UDim2.new(0, 778, 0, 500)
    self.Position = options.Position or UDim2.new(0.1572, 0, 0.18194, 0)
    self.Transparency = options.Transparency or 0
    self.Blur = options.Blur or false
    self.Resizable = options.Resizable or false
    self.MinSize = options.MinSize or UDim2.new(0, 400, 0, 300)
    self.MaxSize = options.MaxSize or UDim2.new(0, 1200, 0, 900)
    self.AutoSave = options.AutoSave or true
    self.Dock = options.Dock or "None"
    self.Floating = options.Floating or true
    
    -- State
    self.IsVisible = true
    self.IsLocked = false
    self.Tabs = {}
    self.ActiveTab = nil
    self.ActiveTabIndex = 0
    self.Components = {}
    self.Sections = {}
    
    -- Manager instances
    self._janitor = Janitor.new()
    
    -- Create GUI
    self:_createGUI()
    
    -- Setup drag
    self:_setupDrag()
    
    -- Setup search
    self._searchEnabled = false
    
    return self
end

function Window:_createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    screenGui.Name = "Lumina_" .. self.Title
    
    -- Main frame with glass effect
    local frame = Instance.new("Frame")
    frame.Size = self.Size
    frame.Position = self.Position
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    -- Glass effect background
    local glass = Instance.new("Frame")
    glass.Size = UDim2.new(1, 0, 1, 0)
    glass.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    glass.BackgroundTransparency = 0.03
    glass.BorderSizePixel = 0
    glass.Parent = frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    -- Shadow
    local shadow = Instance.new("UIStroke")
    shadow.Thickness = 1
    shadow.Color = Color3.fromRGB(255, 255, 255)
    shadow.Transparency = 0.1
    shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    shadow.Parent = frame
    
    -- Inner shadow
    local innerShadow = Instance.new("UIStroke")
    innerShadow.Thickness = 1
    innerShadow.Color = Color3.fromRGB(0, 0, 0)
    innerShadow.Transparency = 0.3
    innerShadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    innerShadow.Parent = frame
    
    -- Title bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    titleBar.BackgroundTransparency = 0.05
    titleBar.BorderSizePixel = 0
    titleBar.Parent = frame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar
    
    -- Icon (if provided)
    if self.Icon and self.Icon ~= "" then
        local iconImg = Instance.new("ImageLabel")
        iconImg.Size = UDim2.new(0, 24, 0, 24)
        iconImg.Position = UDim2.new(0.02, 0, 0.5, -12)
        iconImg.BackgroundTransparency = 1
        iconImg.Image = self.Icon
        iconImg.Parent = titleBar
    end
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    titleLabel.Position = UDim2.new(0.07, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = self.Title
    titleLabel.TextSize = 20
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.FontFace = Font.new("rbxasset://fonts/families/Fondamento.json")
    titleLabel.Parent = titleBar
    
    -- Subtitle
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Size = UDim2.new(0.3, 0, 0.4, 0)
    subtitleLabel.Position = UDim2.new(0.07, 0, 0.6, 0)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = self.SubTitle
    subtitleLabel.TextSize = 12
    subtitleLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subtitleLabel.FontFace = Font.new("rbxasset://fonts/families/Fondamento.json")
    subtitleLabel.Parent = titleBar
    
    -- Window controls
    local controls = Instance.new("Frame")
    controls.Size = UDim2.new(0, 120, 0, 30)
    controls.Position = UDim2.new(1, -130, 0.5, -15)
    controls.BackgroundTransparency = 1
    controls.BorderSizePixel = 0
    controls.Parent = titleBar
    
    -- Minimize button
    local minimizeBtn = Instance.new("ImageButton")
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position = UDim2.new(0, 0, 0, 0)
    minimizeBtn.BackgroundTransparency = 1
    minimizeBtn.Image = "rbxassetid://10747384394"
    minimizeBtn.ImageColor3 = Color3.fromRGB(200, 200, 210)
    minimizeBtn.ImageRectSize = Vector2.new(24, 24)
    minimizeBtn.Parent = controls
    
    -- Maximize button
    local maximizeBtn = Instance.new("ImageButton")
    maximizeBtn.Size = UDim2.new(0, 30, 0, 30)
    maximizeBtn.Position = UDim2.new(0, 35, 0, 0)
    maximizeBtn.BackgroundTransparency = 1
    maximizeBtn.Image = "rbxassetid://10747384552"
    maximizeBtn.ImageColor3 = Color3.fromRGB(200, 200, 210)
    maximizeBtn.ImageRectSize = Vector2.new(24, 24)
    maximizeBtn.Parent = controls
    
    -- Close button
    local closeBtn = Instance.new("ImageButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(0, 70, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Image = "rbxassetid://10747384394"
    closeBtn.ImageColor3 = Color3.fromRGB(255, 60, 60)
    closeBtn.ImageRectSize = Vector2.new(24, 24)
    closeBtn.Parent = controls
    
    -- Tab container with enhanced design
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0, 160, 1, -50)
    tabContainer.Position = UDim2.new(0, 0, 0, 50)
    tabContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    tabContainer.BackgroundTransparency = 0.03
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = frame
    
    -- Tab container border
    local tabBorder = Instance.new("Frame")
    tabBorder.Size = UDim2.new(0, 1, 1, 0)
    tabBorder.Position = UDim2.new(1, 0, 0, 0)
    tabBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabBorder.BackgroundTransparency = 0.05
    tabBorder.BorderSizePixel = 0
    tabBorder.Parent = tabContainer
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 12)
    tabCorner.Parent = tabContainer
    
    -- Tab list with padding
    local tabList = Instance.new("UIListLayout")
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Padding = UDim.new(0, 4)
    tabList.Parent = tabContainer
    
    -- Main content
    local mainContent = Instance.new("Frame")
    mainContent.Size = UDim2.new(1, -160, 1, -50)
    mainContent.Position = UDim2.new(0, 160, 0, 50)
    mainContent.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    mainContent.BackgroundTransparency = 0.05
    mainContent.BorderSizePixel = 0
    mainContent.Parent = frame
    
    -- Search bar
    local searchBar = Instance.new("TextBox")
    searchBar.Size = UDim2.new(1, -20, 0, 32)
    searchBar.Position = UDim2.new(0, 10, 0, 8)
    searchBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    searchBar.Text = ""
    searchBar.TextSize = 13
    searchBar.TextColor3 = Color3.fromRGB(200, 200, 210)
    searchBar.PlaceholderText = "Search..."
    searchBar.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
    searchBar.BorderSizePixel = 0
    searchBar.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    searchBar.ClearTextOnFocus = true
    searchBar.Visible = false
    searchBar.Parent = mainContent
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 6)
    searchCorner.Parent = searchBar
    
    -- Search icon
    local searchIcon = Instance.new("ImageLabel")
    searchIcon.Size = UDim2.new(0, 16, 0, 16)
    searchIcon.Position = UDim2.new(0, 8, 0.5, -8)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Image = "rbxassetid://10734943674"
    searchIcon.ImageColor3 = Color3.fromRGB(120, 120, 130)
    searchIcon.Visible = false
    searchIcon.Parent = mainContent
    
    -- Content container
    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, -20, 1, -52)
    contentContainer.Position = UDim2.new(0, 10, 0, 48)
    contentContainer.BackgroundTransparency = 1
    contentContainer.BorderSizePixel = 0
    contentContainer.Parent = mainContent
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 6)
    contentLayout.Parent = contentContainer
    
    -- Store references
    self._gui = {
        ScreenGui = screenGui,
        Frame = frame,
        Glass = glass,
        Corner = corner,
        TitleBar = titleBar,
        TitleLabel = titleLabel,
        SubtitleLabel = subtitleLabel,
        TabContainer = tabContainer,
        TabList = tabList,
        MainContent = mainContent,
        SearchBar = searchBar,
        SearchIcon = searchIcon,
        ContentContainer = contentContainer,
        ContentLayout = contentLayout,
        MinimizeBtn = minimizeBtn,
        MaximizeBtn = maximizeBtn,
        CloseBtn = closeBtn,
        Controls = controls,
        TabBorder = tabBorder,
        Shadow = shadow,
        InnerShadow = innerShadow,
    }
    
    -- Close button
    closeBtn.MouseButton1Click:Connect(function()
        self:Destroy()
    end)
    
    -- Minimize button
    minimizeBtn.MouseButton1Click:Connect(function()
        self:Hide()
    end)
    
    -- Maximize button
    local isMaximized = false
    maximizeBtn.MouseButton1Click:Connect(function()
        if isMaximized then
            self.Size = UDim2.new(0, 778, 0, 500)
            self._gui.Frame.Size = self.Size
            self._gui.Frame.Position = UDim2.new(0.1572, 0, 0.18194, 0)
            isMaximized = false
        else
            self.Size = UDim2.new(1, 0, 1, 0)
            self._gui.Frame.Size = self.Size
            self._gui.Frame.Position = UDim2.new(0, 0, 0, 0)
            isMaximized = true
        end
    end)
    
    self._janitor:Add(screenGui)
end

function Window:_setupDrag()
    local frame = self._gui.Frame
    local dragging = false
    local dragStart = Vector2.new()
    local posStart = UDim2.new()
    
    self._gui.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            posStart = frame.Position
        end
    end)
    
    self._gui.TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    self._gui.TitleBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            local parent = frame.Parent
            
            frame.Position = UDim2.new(
                posStart.X.Scale,
                posStart.X.Offset + delta.X,
                posStart.Y.Scale,
                posStart.Y.Offset + delta.Y
            )
        end
    end)
end

function Window:MakeTab(options)
    local name = options[1] or "Tab"
    local icon = options[2] or ""
    local tabOptions = options[3] or {}
    
    local tab = Tab.new(name, icon, self, tabOptions)
    table.insert(self.Tabs, tab)
    
    -- Create UI
    tab:CreateUI(self._gui.TabContainer, self._gui.ContentContainer)
    
    -- Select first tab
    if #self.Tabs == 1 then
        self:SelectTab(tab)
    end
    
    return tab
end

function Window:SelectTab(tab)
    -- Deselect all tabs
    for _, t in ipairs(self.Tabs) do
        t:Deselect()
    end
    
    -- Select the tab
    tab:Select()
    self.ActiveTab = tab
    self.ActiveTabIndex = table.find(self.Tabs, tab) or 1
    
    return tab
end

function Window:EnableSearch()
    self._searchEnabled = true
    self._gui.SearchBar.Visible = true
    self._gui.SearchIcon.Visible = true
end

function Window:DisableSearch()
    self._searchEnabled = false
    self._gui.SearchBar.Visible = false
    self._gui.SearchIcon.Visible = false
end

function Window:Search(query)
    if not self._searchEnabled then return end
    self._gui.SearchBar.Text = query
end

function Window:Show()
    self.IsVisible = true
    self._gui.Frame.Visible = true
end

function Window:Hide()
    self.IsVisible = false
    self._gui.Frame.Visible = false
end

function Window:Toggle()
    if self.IsVisible then
        self:Hide()
    else
        self:Show()
    end
end

function Window:Destroy()
    self._janitor:Cleanup()
    if self._gui and self._gui.ScreenGui then
        self._gui.ScreenGui:Destroy()
    end
end

function Window:SetTitle(title)
    self.Title = title
    if self._gui and self._gui.TitleLabel then
        self._gui.TitleLabel.Text = title
    end
end

function Window:SetSubtitle(subtitle)
    self.SubTitle = subtitle
    if self._gui and self._gui.SubtitleLabel then
        self._gui.SubtitleLabel.Text = subtitle
    end
end

function Window:SetTheme(theme)
    self.Theme = theme
end

function Window:SetAccent(color)
    self.Accent = color
end

function Window:SetBackground(color)
    if self._gui and self._gui.Frame then
        self._gui.Frame.BackgroundColor3 = color
    end
end

function Window:SetBlur(enabled)
    self.Blur = enabled
end

function Window:SetTransparency(transparency)
    self.Transparency = transparency
    if self._gui and self._gui.Frame then
        self._gui.Frame.BackgroundTransparency = transparency
    end
end

function Window:Center()
    local screenSize = game:GetService("GuiService"):GetScreenSize()
    local frameSize = self._gui.Frame.AbsoluteSize
    self._gui.Frame.Position = UDim2.new(
        0.5, -frameSize.X / 2,
        0.5, -frameSize.Y / 2
    )
end

function Window:Shake(intensity, duration)
    intensity = intensity or 5
    duration = duration or 0.5
    local originalPos = self._gui.Frame.Position
    
    local steps = 10
    for i = 1, steps do
        local offsetX = math.random(-intensity, intensity)
        local offsetY = math.random(-intensity, intensity)
        self._gui.Frame.Position = UDim2.new(
            originalPos.X.Scale,
            originalPos.X.Offset + offsetX,
            originalPos.Y.Scale,
            originalPos.Y.Offset + offsetY
        )
        task.wait(duration / steps)
    end
    
    self._gui.Frame.Position = originalPos
end

function Window:Flash(color, duration)
    color = color or Color3.fromRGB(255, 255, 255)
    duration = duration or 0.3
    
    local original = self._gui.Frame.BackgroundColor3
    self._gui.Frame.BackgroundColor3 = color
    task.wait(duration)
    self._gui.Frame.BackgroundColor3 = original
end

function Window:Lock()
    self.IsLocked = true
end

function Window:Unlock()
    self.IsLocked = false
end

-- Component methods
function Window:AddButton(options)
    local button = require("Button")(options)
    button:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return button
end

function Window:AddToggle(options)
    local toggle = require("Toggle")(options)
    toggle:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return toggle
end

function Window:AddSlider(options)
    local slider = require("Slider")(options)
    slider:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return slider
end

function Window:AddDropdown(options)
    local dropdown = require("Dropdown")(options)
    dropdown:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return dropdown
end

function Window:AddTextbox(options)
    local textbox = require("Textbox")(options)
    textbox:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return textbox
end

function Window:AddLabel(options)
    local label = require("Label")(options)
    label:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return label
end

function Window:AddParagraph(options)
    local paragraph = require("Paragraph")(options)
    paragraph:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return paragraph
end

function Window:AddSeparator(options)
    local separator = require("Separator")(options)
    separator:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return separator
end

function Window:AddMinimizeButton(options)
    -- Already implemented in title bar
    return self._gui.MinimizeBtn
end

-- ============================================================================
-- COMPONENT CLASSES
-- ============================================================================

-- Button Component
local Button = {}
Button.__index = Button

function Button.new(options)
    local self = setmetatable({}, Button)
    self.Name = options.Name or "Button"
    self.Description = options.Description or ""
    self.Icon = options.Icon or ""
    self.Badge = options.Badge or ""
    self.Locked = options.Locked or false
    self.Visible = true
    self.Disabled = false
    self.Confirm = options.Confirm or false
    self.Tooltip = options.Tooltip or ""
    self.Flag = options.Flag or ""
    self.Callback = options.Callback or function() end
    self.Container = nil
    self.Button = nil
    self.SearchKeywords = options.SearchKeywords or {}
    return self
end

function Button:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 46)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, -4)
    button.Position = UDim2.new(0, 0, 0, 2)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.Text = ""
    button.BorderSizePixel = 0
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Icon
    if self.Icon and self.Icon ~= "" then
        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 20, 0, 20)
        icon.Position = UDim2.new(0, 10, 0.5, -10)
        icon.BackgroundTransparency = 1
        icon.Image = self.Icon
        icon.Parent = button
    end
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Name
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    label.Parent = button
    
    -- Badge
    if self.Badge and self.Badge ~= "" then
        local badge = Instance.new("Frame")
        badge.Size = UDim2.new(0, 30, 0, 20)
        badge.Position = UDim2.new(1, -40, 0.5, -10)
        badge.BackgroundColor3 = Color3.fromRGB(98, 0, 238)
        badge.BorderSizePixel = 0
        badge.Parent = button
        
        local badgeCorner = Instance.new("UICorner")
        badgeCorner.CornerRadius = UDim.new(0, 10)
        badgeCorner.Parent = badge
        
        local badgeText = Instance.new("TextLabel")
        badgeText.Size = UDim2.new(1, 0, 1, 0)
        badgeText.BackgroundTransparency = 1
        badgeText.Text = self.Badge
        badgeText.TextSize = 10
        badgeText.TextColor3 = Color3.fromRGB(255, 255, 255)
        badgeText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        badgeText.Parent = badge
    end
    
    -- Description
    if self.Description and self.Description ~= "" then
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(0.5, 0, 1, 0)
        desc.Position = UDim2.new(0.45, 0, 0, 0)
        desc.BackgroundTransparency = 1
        desc.Text = self.Description
        desc.TextSize = 12
        desc.TextColor3 = Color3.fromRGB(150, 150, 160)
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        desc.Parent = button
    end
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        if not self.Locked and not self.Disabled then
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        end
    end)
    
    button.MouseLeave:Connect(function()
        if not self.Locked and not self.Disabled then
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        end
    end)
    
    -- Click
    button.MouseButton1Click:Connect(function()
        if self.Locked or self.Disabled then return end
        
        if self.Confirm then
            label.Text = "Confirm?"
            label.TextColor3 = Color3.fromRGB(255, 200, 50)
            task.wait(1.5)
            label.Text = self.Name
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            return
        end
        
        self.Callback()
    end)
    
    self.Container = container
    self.Button = button
    self.Label = label
    
    return container
end

function Button:SetName(name)
    self.Name = name
    if self.Label then
        self.Label.Text = name
    end
end

function Button:SetDescription(desc)
    self.Description = desc
end

function Button:SetIcon(icon)
    self.Icon = icon
end

function Button:SetLocked(locked)
    self.Locked = locked
    if self.Button then
        self.Button.TextColor3 = locked and Color3.fromRGB(100, 100, 110) or Color3.fromRGB(255, 255, 255)
    end
end

function Button:Fire()
    if not self.Locked and not self.Disabled then
        self.Callback()
    end
end

function Button:Enable()
    self.Disabled = false
    if self.Button then
        self.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        self.Button.BackgroundTransparency = 0
    end
end

function Button:Disable()
    self.Disabled = true
    if self.Button then
        self.Button.TextColor3 = Color3.fromRGB(100, 100, 110)
        self.Button.BackgroundTransparency = 0.3
    end
end

-- Toggle Component
local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(options)
    local self = setmetatable({}, Toggle)
    self.Name = options.Name or "Toggle"
    self.Description = options.Description or ""
    self.Default = options.Default or false
    self.Value = self.Default
    self.Locked = false
    self.Flag = options.Flag or ""
    self.Callback = options.Callback or function() end
    self.SearchKeywords = options.SearchKeywords or {}
    self.Container = nil
    self.Button = nil
    self.Indicator = nil
    self.Toggle = nil
    self.Label = nil
    return self
end

function Toggle:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 42)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, -2)
    button.Position = UDim2.new(0, 0, 0, 1)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.Text = ""
    button.BorderSizePixel = 0
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Name
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    label.Parent = button
    
    -- Description
    if self.Description and self.Description ~= "" then
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(0.5, 0, 1, 0)
        desc.Position = UDim2.new(0.45, 0, 0, 0)
        desc.BackgroundTransparency = 1
        desc.Text = self.Description
        desc.TextSize = 12
        desc.TextColor3 = Color3.fromRGB(150, 150, 160)
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        desc.Parent = button
    end
    
    -- Toggle indicator
    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 44, 0, 24)
    toggleBg.Position = UDim2.new(1, -54, 0.5, -12)
    toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = button
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleBg
    
    local toggleDot = Instance.new("Frame")
    toggleDot.Size = UDim2.new(0, 18, 0, 18)
    toggleDot.Position = self.Value and UDim2.new(1, -24, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    toggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleDot.BorderSizePixel = 0
    toggleDot.Parent = toggleBg
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = toggleDot
    
    self.Container = container
    self.Button = button
    self.Toggle = toggleBg
    self.Indicator = toggleDot
    self.Label = label
    
    -- Set initial state
    self:_updateToggle()
    
    -- Click handler
    button.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    return container
end

function Toggle:_updateToggle()
    if self.Value then
        self.Toggle.BackgroundColor3 = Color3.fromRGB(98, 0, 238)
        self.Indicator.Position = UDim2.new(1, -24, 0.5, -9)
        if self.Label then
            self.Label.TextColor3 = Color3.fromRGB(98, 0, 238)
        end
    else
        self.Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        self.Indicator.Position = UDim2.new(0, 3, 0.5, -9)
        if self.Label then
            self.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
end

function Toggle:Toggle()
    if self.Locked then return end
    self.Value = not self.Value
    self:_updateToggle()
    self.Callback(self.Value)
end

function Toggle:Set(value)
    if self.Locked then return end
    self.Value = value
    self:_updateToggle()
    self.Callback(self.Value)
end

function Toggle:Get()
    return self.Value
end

function Toggle:Lock()
    self.Locked = true
end

function Toggle:Unlock()
    self.Locked = false
end

function Toggle:Enable()
    self.Locked = false
end

function Toggle:Disable()
    self.Locked = true
end

-- Slider Component
local Slider = {}
Slider.__index = Slider

function Slider.new(options)
    local self = setmetatable({}, Slider)
    self.Name = options.Name or "Slider"
    self.Description = options.Description or ""
    self.Min = options.Min or 0
    self.Max = options.Max or 100
    self.Default = options.Default or 50
    self.Value = self.Default
    self.Integer = options.Integer or false
    self.Suffix = options.Suffix or ""
    self.Prefix = options.Prefix or ""
    self.Precision = options.Precision or 0
    self.Locked = false
    self.Flag = options.Flag or ""
    self.Callback = options.Callback or function() end
    self.SearchKeywords = options.SearchKeywords or {}
    self.Container = nil
    self.Button = nil
    self.Bar = nil
    self.Fill = nil
    self.ValueLabel = nil
    return self
end

function Slider:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 52)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, -2)
    button.Position = UDim2.new(0, 0, 0, 1)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.Text = ""
    button.BorderSizePixel = 0
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 0.5, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Name
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    label.Parent = button
    
    -- Description
    if self.Description and self.Description ~= "" then
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(0.5, 0, 0.5, 0)
        desc.Position = UDim2.new(0.05, 0, 0.5, 0)
        desc.BackgroundTransparency = 1
        desc.Text = self.Description
        desc.TextSize = 12
        desc.TextColor3 = Color3.fromRGB(150, 150, 160)
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        desc.Parent = button
        label.Size = UDim2.new(0.4, 0, 0.5, 0)
    end
    
    -- Value display
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 60, 1, 0)
    valueLabel.Position = UDim2.new(1, -70, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(self.Value)
    valueLabel.TextSize = 14
    valueLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    valueLabel.Parent = button
    
    -- Slider bar
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0.35, 0, 0, 4)
    bar.Position = UDim2.new(0.5, -20, 0.8, 0)
    bar.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    bar.BorderSizePixel = 0
    bar.Parent = button
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar
    
    -- Fill
    local fill = Instance.new("Frame")
    local percentage = (self.Value - self.Min) / (self.Max - self.Min)
    fill.Size = UDim2.new(percentage, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(98, 0, 238)
    fill.BorderSizePixel = 0
    fill.Parent = bar
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    self.Container = container
    self.Button = button
    self.Bar = bar
    self.Fill = fill
    self.ValueLabel = valueLabel
    self.Label = label
    
    -- Mouse drag
    local dragging = false
    
    button.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    button.MouseButton1Up:Connect(function()
        dragging = false
    end)
    
    button.MouseLeave:Connect(function()
        dragging = false
    end)
    
    button.MouseMoved:Connect(function()
        if not dragging then return end
        local mouse = game:GetService("UserInputService"):GetMouseLocation()
        local absPos = button.AbsolutePosition
        local absSize = button.AbsoluteSize
        local relativeX = (mouse.X - absPos.X) / absSize.X
        relativeX = math.clamp(relativeX, 0, 1)
        
        local value = self.Min + (self.Max - self.Min) * relativeX
        if self.Integer then
            value = math.round(value)
        else
            local factor = 10 ^ (self.Precision or 1)
            value = math.round(value * factor) / factor
        end
        value = math.clamp(value, self.Min, self.Max)
        
        self.Value = value
        self:_updateSlider()
        self.Callback(self.Value)
    end)
    
    return container
end

function Slider:_updateSlider()
    local percentage = (self.Value - self.Min) / (self.Max - self.Min)
    self.Fill.Size = UDim2.new(percentage, 0, 1, 0)
    
    local display = self.Value
    if self.Integer then
        display = math.round(display)
    end
    self.ValueLabel.Text = self.Prefix .. tostring(display) .. self.Suffix
end

function Slider:Set(value)
    if self.Locked then return end
    value = math.clamp(value, self.Min, self.Max)
    if self.Integer then
        value = math.round(value)
    end
    self.Value = value
    self:_updateSlider()
    self.Callback(self.Value)
end

function Slider:Get()
    return self.Value
end

function Slider:SetMin(min)
    self.Min = min
    self.Value = math.max(self.Value, min)
    self:_updateSlider()
end

function Slider:SetMax(max)
    self.Max = max
    self.Value = math.min(self.Value, max)
    self:_updateSlider()
end

-- Dropdown Component
local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.new(options)
    local self = setmetatable({}, Dropdown)
    self.Name = options.Name or "Dropdown"
    self.Description = options.Description or ""
    self.Options = options.Options or {}
    self.Default = options.Default or ""
    self.Value = self.Default
    self.MultiSelect = options.MultiSelect or false
    self.Searchable = options.Searchable or false
    self.Icons = options.Icons or {}
    self.Locked = false
    self.Flag = options.Flag or ""
    self.Callback = options.Callback or function() end
    self.SearchKeywords = options.SearchKeywords or {}
    self.Container = nil
    self.Button = nil
    self.OptionsContainer = nil
    self.IsOpen = false
    self.SelectedOptions = self.MultiSelect and {} or ""
    return self
end

function Dropdown:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 48)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 32)
    button.Position = UDim2.new(0, 0, 0, 2)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.Text = ""
    button.BorderSizePixel = 0
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Name
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    label.Parent = button
    
    -- Value display
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.5, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.45, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = self.Value or "Select..."
    valueLabel.TextSize = 13
    valueLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Left
    valueLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    valueLabel.Parent = button
    
    -- Arrow
    local arrow = Instance.new("ImageLabel")
    arrow.Size = UDim2.new(0, 16, 0, 16)
    arrow.Position = UDim2.new(1, -24, 0.5, -8)
    arrow.BackgroundTransparency = 1
    arrow.Image = "rbxassetid://10709790948"
    arrow.ImageColor3 = Color3.fromRGB(150, 150, 160)
    arrow.Parent = button
    
    -- Options container
    local optionsContainer = Instance.new("Frame")
    optionsContainer.Size = UDim2.new(1, 0, 0, 0)
    optionsContainer.Position = UDim2.new(0, 0, 0, 36)
    optionsContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    optionsContainer.BorderSizePixel = 0
    optionsContainer.ClipsDescendants = true
    optionsContainer.Visible = false
    optionsContainer.Parent = container
    
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = UDim.new(0, 8)
    optionsCorner.Parent = optionsContainer
    
    -- Options layout
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 2)
    layout.Parent = optionsContainer
    
    -- Add options
    for _, option in ipairs(self.Options) do
        self:_createOption(optionsContainer, option)
    end
    
    self.Container = container
    self.Button = button
    self.OptionsContainer = optionsContainer
    self.Arrow = arrow
    self.Label = label
    self.ValueLabel = valueLabel
    self.Layout = layout
    
    -- Click to toggle
    button.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    return container
end

function Dropdown:_createOption(parent, optionText)
    local option = Instance.new("TextButton")
    option.Size = UDim2.new(1, 0, 0, 28)
    option.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    option.Text = optionText
    option.TextSize = 13
    option.TextColor3 = Color3.fromRGB(200, 200, 210)
    option.TextXAlignment = Enum.TextXAlignment.Left
    option.BorderSizePixel = 0
    option.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    option.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = option
    
    -- Hover
    option.MouseEnter:Connect(function()
        option.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    end)
    
    option.MouseLeave:Connect(function()
        option.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    end)
    
    -- Click
    option.MouseButton1Click:Connect(function()
        self:Select(optionText)
    end)
    
    return option
end

function Dropdown:Toggle()
    if self.Locked then return end
    self.IsOpen = not self.IsOpen
    self.OptionsContainer.Visible = self.IsOpen
    
    if self.IsOpen then
        self.Arrow.Rotation = 180
        local height = math.min(#self.Options * 30, 150)
        self.OptionsContainer.Size = UDim2.new(1, 0, 0, height)
    else
        self.Arrow.Rotation = 0
        self.OptionsContainer.Size = UDim2.new(1, 0, 0, 0)
        task.wait(0.2)
        self.OptionsContainer.Visible = false
    end
end

function Dropdown:Select(option)
    if self.Locked then return end
    
    if self.MultiSelect then
        local index = table.find(self.SelectedOptions, option)
        if index then
            table.remove(self.SelectedOptions, index)
        else
            table.insert(self.SelectedOptions, option)
        end
        self.ValueLabel.Text = table.concat(self.SelectedOptions, ", ")
    else
        self.Value = option
        self.ValueLabel.Text = option
    end
    
    self.Callback(option)
    
    if not self.MultiSelect then
        self:Toggle()
    end
end

function Dropdown:Add(option)
    table.insert(self.Options, option)
    if self.OptionsContainer then
        self:_createOption(self.OptionsContainer, option)
    end
end

function Dropdown:Remove(option)
    for i, opt in ipairs(self.Options) do
        if opt == option then
            table.remove(self.Options, i)
            break
        end
    end
    self:Refresh()
end

function Dropdown:Refresh()
    if self.OptionsContainer then
        for _, child in ipairs(self.OptionsContainer:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        for _, option in ipairs(self.Options) do
            self:_createOption(self.OptionsContainer, option)
        end
    end
end

function Dropdown:Clear()
    self.Options = {}
    self.SelectedOptions = {}
    self:Refresh()
end

function Dropdown:Set(value)
    if self.Locked then return end
    self.Value = value
    self.ValueLabel.Text = value
    self.Callback(value)
end

function Dropdown:Get()
    return self.Value
end

-- Textbox Component
local Textbox = {}
Textbox.__index = Textbox

function Textbox.new(options)
    local self = setmetatable({}, Textbox)
    self.Name = options.Name or "Textbox"
    self.Description = options.Description or ""
    self.Placeholder = options.Placeholder or "Enter text..."
    self.Default = options.Default or ""
    self.NumbersOnly = options.NumbersOnly or false
    self.Regex = options.Regex or nil
    self.Locked = false
    self.Flag = options.Flag or ""
    self.Callback = options.Callback or function() end
    self.SearchKeywords = options.SearchKeywords or {}
    self.Container = nil
    self.TextBox = nil
    self.Label = nil
    return self
end

function Textbox:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 48)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    -- Label
    if self.Name and self.Name ~= "" then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.4, 0, 0.4, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = self.Name
        label.TextSize = 13
        label.TextColor3 = Color3.fromRGB(200, 200, 210)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        label.Parent = container
        self.Label = label
    end
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, 0, 0, 32)
    textBox.Position = UDim2.new(0, 0, 0, 14)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    textBox.Text = self.Default
    textBox.TextSize = 14
    textBox.TextColor3 = Color3.fromRGB(200, 200, 210)
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.PlaceholderText = self.Placeholder
    textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
    textBox.BorderSizePixel = 0
    textBox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    textBox.ClearTextOnFocus = true
    textBox.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = textBox
    
    self.Container = container
    self.TextBox = textBox
    
    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        if self.Locked then return end
        
        local text = textBox.Text
        
        if self.NumbersOnly then
            text = text:gsub("%D", "")
            textBox.Text = text
        end
        
        if self.Regex then
            if not string.match(text, self.Regex) then
                textBox.Text = self.Default
                return
            end
        end
        
        self.Callback(text)
    end)
    
    return container
end

function Textbox:Set(text)
    if self.Locked then return end
    if self.TextBox then
        self.TextBox.Text = text
    end
    self.Callback(text)
end

function Textbox:Get()
    return self.TextBox and self.TextBox.Text or ""
end

function Textbox:Clear()
    if self.TextBox then
        self.TextBox.Text = ""
    end
end

-- Label Component
local Label = {}
Label.__index = Label

function Label.new(options)
    local self = setmetatable({}, Label)
    self.Text = options.Text or ""
    self.Size = options.Size or 14
    self.Color = options.Color or Color3.fromRGB(255, 255, 255)
    self.Font = options.Font or "SourceSansPro"
    self.Alignment = options.Alignment or "Left"
    self.Container = nil
    self.Label = nil
    return self
end

function Label:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 32)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Text
    label.TextSize = self.Size
    label.TextColor3 = self.Color
    label.TextXAlignment = self.Alignment == "Left" and Enum.TextXAlignment.Left or 
                         self.Alignment == "Center" and Enum.TextXAlignment.Center or 
                         Enum.TextXAlignment.Right
    label.FontFace = Font.new("rbxasset://fonts/families/" .. self.Font .. ".json")
    label.Parent = container
    
    self.Container = container
    self.Label = label
    
    return container
end

function Label:SetText(text)
    self.Text = text
    if self.Label then
        self.Label.Text = text
    end
end

-- Paragraph Component
local Paragraph = {}
Paragraph.__index = Paragraph

function Paragraph.new(options)
    local self = setmetatable({}, Paragraph)
    self.Text = options.Text or ""
    self.Size = options.Size or 13
    self.Color = options.Color or Color3.fromRGB(200, 200, 210)
    self.Container = nil
    self.Label = nil
    return self
end

function Paragraph:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Text
    label.TextSize = self.Size
    label.TextColor3 = self.Color
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    label.Parent = container
    
    -- Auto size based on content
    label.Size = UDim2.new(1, -10, 0, label.TextBounds.Y + 4)
    container.Size = UDim2.new(1, 0, 0, label.AbsoluteSize.Y + 4)
    
    self.Container = container
    self.Label = label
    
    return container
end

function Paragraph:SetText(text)
    self.Text = text
    if self.Label then
        self.Label.Text = text
        self.Label.Size = UDim2.new(1, -10, 0, self.Label.TextBounds.Y + 4)
        self.Container.Size = UDim2.new(1, 0, 0, self.Label.AbsoluteSize.Y + 4)
    end
end

-- Separator Component
local Separator = {}
Separator.__index = Separator

function Separator.new(options)
    local self = setmetatable({}, Separator)
    self.Text = options.Text or ""
    self.Container = nil
    return self
end

function Separator:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 32)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, -20, 0, 1)
    line.Position = UDim2.new(0, 10, 0.5, 0)
    line.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    line.BorderSizePixel = 0
    line.Parent = container
    
    if self.Text and self.Text ~= "" then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 100, 0, 20)
        label.Position = UDim2.new(0.5, -50, 0.5, -10)
        label.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
        label.Text = self.Text
        label.TextSize = 12
        label.TextColor3 = Color3.fromRGB(120, 120, 130)
        label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        label.Parent = container
    end
    
    self.Container = container
    return container
end

-- ============================================================================
-- LUMINA API
-- ============================================================================

local LuminaState = {
    Windows = {},
    ActiveWindow = nil,
    IsInitialized = false,
    Config = {
        DebugMode = false,
        ReleaseMode = true,
        DefaultTheme = "Dark",
        DefaultAccent = Color3.fromRGB(98, 0, 238),
        SaveFolder = "LuminaConfig.json",
        NotificationQueue = true,
        MaxNotifications = 5,
        AnimationSpeed = 0.3,
        SoundEnabled = true,
        IconsEnabled = true,
    }
}

local function Initialize()
    if LuminaState.IsInitialized then return end
    LuminaState.IsInitialized = true
    
    if LuminaState.Config.DebugMode then
        print("[Lumina] Framework initialized")
    end
end

-- Public API
function Lumina:MakeWindow(options)
    Initialize()
    
    local window = Window.new(options)
    table.insert(LuminaState.Windows, window)
    LuminaState.ActiveWindow = window
    
    return window
end

function Lumina:Notify(options)
    print("[Lumina Notification]", options.Title, options.Content)
    -- Simple notification implementation
    if options.Type == "Success" then
        print("✅", options.Title, options.Content)
    elseif options.Type == "Error" then
        print("❌", options.Title, options.Content)
    elseif options.Type == "Warning" then
        print("⚠️", options.Title, options.Content)
    else
        print("ℹ️", options.Title, options.Content)
    end
    return {
        Close = function() print("Notification closed") end,
        Update = function() print("Notification updated") end,
    }
end

function Lumina:MakeNotification(options)
    return self:Notify({
        Title = options.Title,
        Content = options.Content,
        Duration = options.Time,
        Icon = options.Icon,
        Type = options.Type
    })
end

function Lumina:Toast(options)
    print("[Lumina Toast]", options.Content)
    return {}
end

function Lumina:Dialog(options)
    print("[Lumina Dialog]", options.Title, options.Content)
    if options.Callback then
        if options.Buttons then
            options.Callback(options.Buttons[1] or "OK")
        end
    end
end

function Lumina:Prompt(options)
    print("[Lumina Prompt]", options.Title, options.Content)
    if options.Callback then
        options.Callback("")
    end
end

function Lumina:GetTheme()
    return "Dark"
end

function Lumina:SetTheme(theme)
    return true
end

function Lumina:GetAccent()
    return Color3.fromRGB(98, 0, 238)
end

function Lumina:SetAccent(color)
    return true
end

function Lumina:SetConfig(config)
    for key, value in pairs(config) do
        LuminaState.Config[key] = value
    end
end

function Lumina:GetConfig()
    return table.clone(LuminaState.Config)
end

function Lumina:GetWindows()
    return LuminaState.Windows
end

function Lumina:GetActiveWindow()
    return LuminaState.ActiveWindow
end

function Lumina:Destroy()
    for _, window in ipairs(LuminaState.Windows) do
        window:Destroy()
    end
    LuminaState.Windows = {}
    LuminaState.ActiveWindow = nil
    LuminaState.IsInitialized = false
end

function Lumina:DebugMode(enabled)
    LuminaState.Config.DebugMode = enabled
    print("[Lumina] Debug mode:", enabled)
end

function Lumina:GetVersion()
    return "1.0.0"
end

function Lumina:GetIcons()
    return Icons
end

function Lumina:GetIcon(name)
    return Icons[name]
end

-- Backward compatibility
Lumina.MakeWindow = Lumina.MakeWindow
Lumina.MakeNotification = Lumina.MakeNotification
Lumina.Notify = Lumina.Notify

-- ============================================================================
-- EXAMPLES
-- ============================================================================

return Lumina

--[[
    ============================================================================
    USAGE EXAMPLES
    ============================================================================
    
    -- Basic usage
    local Lumina = loadstring(game:HttpGet("https://your-url/Lumina.lua"))()
    
    -- Create window with icons
    local Window = Lumina:MakeWindow({
        Title = "Lumina Library",
        SubTitle = "Modern UI Framework with Icons",
        Icon = Lumina:GetIcon("sparkles"),
        SaveFolder = "LuminaConfig.json"
    })
    
    -- Create tabs with icons
    local MainTab = Window:MakeTab({"Main", Lumina:GetIcon("home")})
    local SettingsTab = Window:MakeTab({"Settings", Lumina:GetIcon("settings")})
    local AboutTab = Window:MakeTab({"About", Lumina:GetIcon("info")})
    
    -- Add components with icons
    MainTab:AddButton({
        Name = "Click Me",
        Description = "This is a button with an icon",
        Icon = Lumina:GetIcon("rocket"),
        Callback = function()
            Lumina:Notify({
                Title = "Button Clicked",
                Content = "You clicked the button!",
                Type = "Success"
            })
        end
    })
    
    MainTab:AddToggle({
        Name = "Feature Toggle",
        Description = "Enable/disable a feature",
        Icon = Lumina:GetIcon("toggleleft"),
        Default = false,
        Callback = function(value)
            print("Toggle:", value)
        end
    })
    
    MainTab:AddSlider({
        Name = "Volume Control",
        Description = "Adjust volume level",
        Min = 0,
        Max = 100,
        Default = 50,
        Integer = true,
        Suffix = "%",
        Callback = function(value)
            print("Volume:", value)
        end
    })
    
    MainTab:AddDropdown({
        Name = "Theme Selector",
        Description = "Choose a theme",
        Options = {"Dark", "Light", "Glass", "Midnight", "Ocean"},
        Default = "Dark",
        Callback = function(value)
            Lumina:SetTheme(value)
        end
    })
    
    MainTab:AddTextbox({
        Name = "Username",
        Description = "Enter your username",
        Placeholder = "Username...",
        Callback = function(value)
            print("Username:", value)
        end
    })
    
    MainTab:AddSeparator({})
    
    MainTab:AddLabel({
        Text = "This is a label with icon support",
        Size = 14,
        Color = Color3.fromRGB(255, 255, 255)
    })
    
    MainTab:AddParagraph({
        Text = "This is a paragraph component that supports multiple lines of text. It will automatically wrap and adjust its height based on content.",
        Size = 13,
        Color = Color3.fromRGB(200, 200, 210)
    })
    
    -- Enable search
    Window:EnableSearch()
    
    -- Center window
    Window:Center()
    
    -- Show window    Window:Show()
]]
