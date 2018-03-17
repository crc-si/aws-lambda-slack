deploy-s3:
	aws cloudformation create-stack \
		--capabilities CAPABILITY_NAMED_IAM \
      	--stack-name slack-website-bucket \
		--template-body file://s3-website.json

upload:
	aws s3 sync ./docs s3://slack.sssi.org.au --acl public-read
