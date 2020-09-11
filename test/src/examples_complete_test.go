package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
	}
	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	region := terraform.Output(t, terraformOptions, "region")
	fixed := terraform.Output(t, terraformOptions, "fixed")
	short := terraform.Output(t, terraformOptions, "short")
	fixed_round_trip := terraform.Output(t, terraformOptions, "fixed_round_trip")
	short_round_trip := terraform.Output(t, terraformOptions, "short_round_trip")

	// Verify we're getting back the outputs we expect
	assert.Len(t, fixed, 3)
	assert.GreaterOrEqual(t, len(short), 4)
	assert.LessOrEqual(t, len(short), 6)
	assert.Equal(t, region, fixed_round_trip)
	assert.Equal(t, region, short_round_trip)
}
