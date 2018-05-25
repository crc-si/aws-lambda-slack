BUCKET=slack.opendatacube.org

deploy:
	aws cloudformation create-stack \
		--capabilities CAPABILITY_NAMED_IAM \
		--stack-name slack-joiner-odc \
		--parameters \
			ParameterKey=SlackTeamSubDomain,ParameterValue=opendatacube \
			ParameterKey=SlackAuthToken,ParameterValue=$(SLACK_TOKEN) \
			ParameterKey=Origin,ParameterValue=http://slack.opendatacube.org \
		--template-body=file://cloudformation.json

update: 
	aws cloudformation update-stack \
		--capabilities CAPABILITY_NAMED_IAM \
		--stack-name slack-joiner-odc \
		--parameters \
			ParameterKey=SlackTeamSubDomain,ParameterValue=opendatacube \
			ParameterKey=SlackAuthToken,ParameterValue=$(SLACK_TOKEN) \
			ParameterKey=Origin,ParameterValue=http://slack.opendatacube.org \
		--template-body=file://cloudformation.json

deploy-s3:
	aws cloudformation create-stack \
		--capabilities CAPABILITY_NAMED_IAM \
      	--stack-name slack-joiner-odc-website-bucket \
		--parameters \
			ParameterKey=BucketName,ParameterValue=$(BUCKET) \
		--template-body file://s3-website.json

update-s3:
	aws cloudformation update-stack \
		--capabilities CAPABILITY_NAMED_IAM \
      	--stack-name slack-joiner-odc-website-bucket \
		--parameters \
			ParameterKey=BucketName,ParameterValue=$(BUCKET) \
		--template-body file://s3-website.json

upload:
	aws s3 sync ./docs s3://$(BUCKET) --acl public-read
