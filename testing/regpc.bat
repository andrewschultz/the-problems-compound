echo off

xcopy /q /y \games\inform\compound.inform\build\output.ulx \games\inform\prt\debug-probcomp.ulx

xcopy /q /y \games\inform\compound.inform\Source\reg-pc*.txt \games\inform\prt
7z a reg-pc.zip reg-pc*.txt
7z a reg-pc.zip regpc.bat
