package test

import (
	"os"
	"regexp"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	testStructure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func cleanup(t *testing.T, terraformOptions *terraform.Options, tempTestFolder string) {
	terraform.Destroy(t, terraformOptions)
	os.RemoveAll(tempTestFolder)
}

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()
	randID := strings.ToLower(random.UniqueId())
	attributes := []string{randID}

	rootFolder := "../../"
	terraformFolderRelativeToRoot := "examples/complete"
	varFiles := []string{"fixtures.us-east-2.tfvars"}

	tempTestFolder := testStructure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: tempTestFolder,
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: varFiles,
		Vars: map[string]interface{}{
			"attributes": attributes,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer cleanup(t, terraformOptions, tempTestFolder)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	region := terraform.Output(t, terraformOptions, "region")
	fixed := terraform.Output(t, terraformOptions, "fixed")
	short := terraform.Output(t, terraformOptions, "short")
	fixedRoundTrip := terraform.Output(t, terraformOptions, "fixed_round_trip")
	shortRoundTrip := terraform.Output(t, terraformOptions, "short_round_trip")
	enabledRegions := terraform.OutputList(t, terraformOptions, "enabled_regions")
	//disabledRegions := terraform.OutputList(t, terraformOptions, "disabled_regions")
	idSize := terraform.Output(t, terraformOptions, "identity_size")

	// Verify we're getting back the outputs we expect
	assert.Len(t, fixed, 3)
	assert.GreaterOrEqual(t, len(short), 4)
	assert.LessOrEqual(t, len(short), 6)
	assert.Equal(t, region, fixedRoundTrip)
	assert.Equal(t, region, shortRoundTrip)
	assert.Contains(t, enabledRegions, "us-east-1")
	// We may enable all regions in the test account
	//assert.Contains(t, disabledRegions, "af-south-1")

	assert.Equal(t, idSize, terraform.Output(t, terraformOptions, "to_short_size"), "Transformation maps are different sizes")
	assert.Equal(t, idSize, terraform.Output(t, terraformOptions, "to_fixed_size"), "Transformation maps are different sizes")
	assert.Equal(t, idSize, terraform.Output(t, terraformOptions, "from_short_size"), "Transformation maps are different sizes")
	assert.Equal(t, idSize, terraform.Output(t, terraformOptions, "from_fixed_size"), "Transformation maps are different sizes")

}

func TestExamplesCompleteDisabled(t *testing.T) {
	t.Parallel()
	randID := strings.ToLower(random.UniqueId())
	attributes := []string{randID}

	rootFolder := "../../"
	terraformFolderRelativeToRoot := "examples/complete"
	varFiles := []string{"fixtures.us-east-2.tfvars"}

	tempTestFolder := testStructure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: tempTestFolder,
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: varFiles,
		Vars: map[string]interface{}{
			"attributes": attributes,
			"enabled":    "false",
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer cleanup(t, terraformOptions, tempTestFolder)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	results := terraform.InitAndApply(t, terraformOptions)

	// Should complete successfully without creating or changing any resources.
	// Extract the "Resources:" section of the output to make the error message more readable.
	re := regexp.MustCompile(`Resources: [^.]+\.`)
	match := re.FindString(results)
	assert.Equal(t, "Resources: 0 added, 0 changed, 0 destroyed.", match, "Deploying with `enabled = false` should not create any resources.")
}
