.PHONY: create-cluster
create-cluster:
	kind create cluster --config config.yml

# Deploy helm charts
.PHONY: deploy
deploy:
	helmfile apply -f helmfile.yaml

# Show differences in helm deployments
.PHONY: diff
diff:
	helmfile diff
