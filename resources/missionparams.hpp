	/*
* Multiplayer lobby paramters
*
*/
class Params{
	///paramsArray [0]
	class Hour {
		title = "Hour";
		values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
		texts[] = {"0000","0100","0200","0300","0400","0500","0600","0700","0800","0900","1000","1100","1200","1300","1400","1500","1600","1700","1800","1900","2000","2100","2200","2300"};
		default = 12;
	};	
	///paramsArray 1
	class MoonSetting {
		title = "Moon State";
		values[] = {1,2,3};
		texts[] =  {"Full Moon","Half Moon","New Moon"};
		default = 2;
	};
	///paramsArray 2
	class TagChecker{
		title = "Tag Check";
		values[] = {1,2};
		texts[] = {"On (battle)","Off (training)"};
		default = 2;
	};
	///paramsArray 3
	 class TrainingMode{
		title = "Training Mode";
		values[] = {1,2};
		texts[] = {"on (training)","off (battle)"};
		default = 1;
	};
	 ///paramsArray 4
	 class IntroToggle{
		title = "Intro Scene";
		values[] = {1,2};
		texts[] = {"Intro on (battle)","Intro off (training)"};
		default = 2;
	};
	///paramsArray 5
	 class MarkerMode{
		title = "Marker Mode";
		values[] = {1,2,3};
		texts[] = {"Markers Off","Markers On (battle)","Global Markers (training)"};
		default = 2;
	};	
	///paramsArray 6
	 class SpawnTime{
		title = "Spawn Time";
		values[] = {10,30,45,60,90,120};
		texts[] = {"10 seconds (training)","30 seconds","45 seconds (battle)","1 Minute","1 1/2 Minute","2 Minutes"};
		default = 10;
	};
	///paramsArray 7
	class ViewDistance{
		title = "View distance";
		values[] = {1000,1500,2000,2500,3000,3500,4000,4500,5000,6000};
		texts[] = {"1000","1500","2000","2500","3000 (battle)","3500","4000","4500","5000","6000"};
		default = 3000;
	};
	///paramsArray 8
	class TerrainGrid{
		title = "Terrain grid";
		values[] = {50,25,12.5,6.25,3.125};
		texts[] = {"Lowest","Low","Normal","High","Highest"};
		default = 6.25;
	};
	///paramsArray 9
	class BattleDuration{
		title = "Battle Duration";
		values[] = {60,180,1800,3600,5400,7200,9000,10800};
		texts[] = {"1 minute (test)","3 minutes (test)","30 minutes","1 Hour","1.5 Hours","2 Hours","2.5 Hours","3 Hours (battle)"};
		default = 10800;
	};
	///paramsArray 10
	class params_fl_TimeBetweenAOs{
		title = "Time between active AOs";
		values[] = {10,30,60,120,300,600};
		texts[] = {"10 sec.","30 sec. (training)","1 minutes","2 minutes","5 minutes","10 minutes (battle)"};
		default = 30;
	};
	///paramsArray 11
	class params_fl_AOPointLimit{
		title = "Obj. control time required for AO control";
		values[] = {-1,60,300};
		texts[] = {"Dynamic","1 max. minute (test)","5 minutes (training)"};
		default = -1;
	};
	///paramsArray 12
	class params_AW_C5_EditorMode{
		title = "Editor Mode";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
	};
	///paramsArray 13
	class params_AW_startAO_0{
		title = "AO 1";
		values[] = {-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49};
		texts[] = {"None","0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49"};
		default = 2;
	};
	///paramsArray 14
	class params_AW_territorySteps{
		title = "Territory Steps";
		values[] = {20,35,50,75,100,125,150};
		texts[] = {"20","35","50","75","100","125","150"};
		default = 50;
	};
};
