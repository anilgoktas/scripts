## make sure this script has "chmod a+x" permission

## Change directory to current one

currentDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $currentDirectory

## Create .xcarchive

xcodebuild -workspace ../Carla.xcworkspace -scheme Carla clean -configuration Debug archive -archivePath ./CarlaDebug.xcarchive

## Create signed .ipa
# Provisioning profile is the one at Xcode 

xcodebuild -exportArchive -archivePath ./CarlaDebug.xcarchive -exportPath ./CarlaDebug.ipa -exportProvisioningProfile "Carla Ad Hoc"
#xcodebuild -exportArchive -archivePath ./Carla.xcarchive -exportPath ./Carla.ipa -exportOptionsPlist exportOptions.plist

## Upload it to Hockey App
# Puck is a command line tool, can be installed inside Hockey App

puck -force=true -submit=auto -notes_path=./distributeNote.txt -notify=true -download=true -open=nothing -app_id="7d4d9d81c99d4f89a57669b4322e7f1e" -api_token="6dc309dc34ee44fbace6aae9424d5d47" ./CarlaDebug.ipa

## Remove builds

rm -rf ./CarlaDebug.ipa
rm -rf ./CarlaDebug.xcarchive