/*
* Created By Jones
* last updated 1/16/2012
*/
enableRadio false;
showCinemaBorder false;
_camStart = position player;
_camStartX =  _camStart select 0;
_camStartY =  _camStart select 1;
_camEnd = position player;
_camEndX = _camEnd select 0; 
_camEndY = _camEnd select 1; 
_camEndZ = (_camEnd select 2) + 1.5; 
_camera = "camera" CamCreate [_camStartX,_camStartY,300];
_camera CameraEffect ["internal","back"];
_camera camSetTarget player;
_camera camPrepareFOV 1.0;
_camera camPreparePos [_camEndX,_camEndY,2];
_camera camCommitPrepared AW_SpawnTime_Param;
waitUntil {camCommitted _camera};
_camera cameraeffect ["terminate","back"];
camdestroy _camera;
enableRadio true;