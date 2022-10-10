PWD:=$(shell pwd)

.PHONY: pack-build
pack-build:
	docker build -t avro-typescript-packer ./pack

.PHONY: pack-run
pack-run:
	echo $(PWD)
	docker run --rm -it --name avro-typescript-packer \
		--volume $(PWD)/../avro-nuget-sandbox/contracts:/contracts --volume $(PWD)/artifacts:/artifacts \
		avro-typescript-packer \
			--package-name=EP.Avro-NuGet-Sandbox.Contracts \
			--package-version=1.5.0 \
			--avro-dir-path=./contracts \
			--output-path=./artifacts \
			--company="Education Perfect" \
			--authors="Team Void"


#--------- Debugging ---------------------------------------
.PHONY: pack-shell
pack-shell:
	docker run --rm -it --name avro-typescript-packer \
		--volume $(PWD)/../avro-nuget-sandbox/contracts:/contracts --volume $(PWD)/artifacts:/artifacts \
		--entrypoint /bin/sh \
		avro-typescript-packer

.PHONY: entrypoint
entrypoint:
	./bin/entrypoint.sh --package-name=EP.Avro-NuGet-Sandbox.Contracts --package-version=1.5.0 --avro-dir-path=/contracts --output-path=./artifacts --company=EP --authors="Team Void"
