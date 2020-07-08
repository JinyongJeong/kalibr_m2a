echo "Start calibration for Motion2AI"
currentPath=$PWD
inputFolder=$PWD/input
outputFolder=$PWD/output
cd ./../../..
source devel/setup.bash
cd $currentPath
#echo "Input Folder" $inputFolder
#echo "Output Folder" $outputFolder
echo $PWD
for targetPath in $inputFolder/* ; do
    	# for directories
	if [ -d "$targetPath" ]; then
		echo "Target path: " "$targetPath"
		mkdir -p $targetPath/cam0
		mv $targetPath/*/*.jpg $targetPath/cam0
		kalibr_bagcreater --folder $targetPath --output-bag $targetPath".bag"
		targetName=$(basename $targetPath)
		echo "Target name: " $targetName
		cd $outputFolder
		mkdir -p $targetName
		cd $targetName
		kalibr_calibrate_cameras --bag $targetPath".bag" --topics /cam0/image_raw --models pinhole-equi --target $currentPath/apriltag.yaml
		# convert calibration.json
		for resultFile in $outputFolder/$targetName/camchain* ; do
			python $currentPath/Conv2Calibration.py $resultFile $outputFolder/$targetName/calibration.json
		done


		cd $currentPath

    	fi
done

