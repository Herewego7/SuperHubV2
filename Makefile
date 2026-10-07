DESTINATION ?= platform=iOS Simulator,name=iPhone 17 Pro,OS=26.5
DERIVED ?= /tmp/superhub-dd

.PHONY: project test

project:
	/bin/sh scripts/host-botlife-sources.sh
	cd ios && xcodegen generate

test: project
	xcodebuild -project ios/SuperHub.xcodeproj -scheme SuperHub -destination '$(DESTINATION)' -derivedDataPath $(DERIVED) test
