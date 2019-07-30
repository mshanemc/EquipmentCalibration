sfdx force:org:create -d 1 -s -f config/project-scratch-def.json
sfdx force:source:push
sfdx force:user:permset:assign -n Equipment_Calibration_User
sfdx force:data:tree:import -p data/Equipment__c-Calibration_Event__c-Task-plan.json
sfdx force:org:open