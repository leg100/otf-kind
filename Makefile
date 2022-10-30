.PHONY: create-cluster
create-cluster:
	kind create cluster --config config.yml

# Deploy helm charts
.PHONY: deploy
deploy:
	IMAGE_TAG=$(IMAGE_TAG) helmfile apply --skip-deps -f helmfile.yaml

# Show differences in helm deployments
.PHONY: diff
diff:
	IMAGE_TAG=$(IMAGE_TAG) helmfile diff --skip-deps
