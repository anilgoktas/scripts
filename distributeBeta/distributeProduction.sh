## make sure this script has "chmod a+x" permission

## Change directory to current one

currentDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $currentDirectory

## Create .xcarchive

xcodebuild -workspace ../Carla.xcworkspace -scheme Carla clean -configuration Release archive -archivePath ./CarlaRelease.xcarchive

## Create signed .ipa
# Provisioning profile is the one at Xcode 

xcodebuild -exportArchive -archivePath ./CarlaRelease.xcarchive -exportPath ./CarlaRelease.ipa -exportProvisioningProfile "Carla Ad Hoc"
#xcodebuild -exportArchive -archivePath ./Carla.xcarchive -exportPath ./Carla.ipa -exportOptionsPlist exportOptions.plist

## Upload it to Hockey App
# Puck is a command line tool, can be installed inside Hockey App

puck -force=true -submit=auto -notes_path=./distributeNote.txt -notify=true -download=true -open=nothing -app_id="hockeyAppID" -api_token="hockeyAPIToken" ./CarlaRelease.ipa

## Remove builds

rm -rf ./CarlaRelease.ipa
rm -rf ./CarlaRelease.xcarchive