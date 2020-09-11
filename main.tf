
locals {
  # Key can be a region, availability zone, or local zone.
  # Key CANNOT be an Availability Zone ID or Wavelength Zone.
  # For some degree of future proofing, we provide mappings for some AZs that do not yet exist.
  # INCLUSION IN THE MAP does NOT necessarily mean the region or AZ exists.

  # See https://github.com/jsonmaur/aws-regions for complete list of regions

  to_fixed = {
    "ap-east-1"  = "ae1"
    "ap-east-1a" = "ae1a"
    "ap-east-1b" = "ae1b"
    "ap-east-1c" = "ae1c"
    "ap-east-1d" = "ae1d"
    "ap-east-1e" = "ae1e"
    "ap-east-1f" = "ae1f"
    "ap-east-1g" = "ae1g"
    "ap-east-1h" = "ae1h"

    "ap-northeast-1"  = "an1"
    "ap-northeast-1a" = "an1a"
    "ap-northeast-1b" = "an1b"
    "ap-northeast-1c" = "an1c"
    "ap-northeast-1d" = "an1d"
    "ap-northeast-1e" = "an1e"
    "ap-northeast-1f" = "an1f"
    "ap-northeast-1g" = "an1g"
    "ap-northeast-1h" = "an1h"

    "ap-northeast-2"  = "an2"
    "ap-northeast-2a" = "an2a"
    "ap-northeast-2b" = "an2b"
    "ap-northeast-2c" = "an2c"
    "ap-northeast-2d" = "an2d"
    "ap-northeast-2e" = "an2e"
    "ap-northeast-2f" = "an2f"
    "ap-northeast-2g" = "an2g"
    "ap-northeast-2h" = "an2h"

    "ap-south-1"  = "as0"
    "ap-south-1a" = "as0a"
    "ap-south-1b" = "as0b"
    "ap-south-1c" = "as0c"
    "ap-south-1d" = "as0d"
    "ap-south-1e" = "as0e"
    "ap-south-1f" = "as0f"
    "ap-south-1g" = "as0g"
    "ap-south-1h" = "as0h"

    "ap-southeast-1"  = "as1"
    "ap-southeast-1a" = "as1a"
    "ap-southeast-1b" = "as1b"
    "ap-southeast-1c" = "as1c"
    "ap-southeast-1d" = "as1d"
    "ap-southeast-1e" = "as1e"
    "ap-southeast-1f" = "as1f"
    "ap-southeast-1g" = "as1g"
    "ap-southeast-1h" = "as1h"

    "ap-southeast-2"  = "as2"
    "ap-southeast-2a" = "as2a"
    "ap-southeast-2b" = "as2b"
    "ap-southeast-2c" = "as2c"
    "ap-southeast-2d" = "as2d"
    "ap-southeast-2e" = "as2e"
    "ap-southeast-2f" = "as2f"
    "ap-southeast-2g" = "as2g"
    "ap-southeast-2h" = "as2h"

    "ca-central-1"  = "cc1"
    "ca-central-1a" = "cc1a"
    "ca-central-1b" = "cc1b"
    "ca-central-1c" = "cc1c"
    "ca-central-1d" = "cc1d"
    "ca-central-1e" = "cc1e"
    "ca-central-1f" = "cc1f"
    "ca-central-1g" = "cc1g"
    "ca-central-1h" = "cc1h"

    "eu-central-1"  = "ec1"
    "eu-central-1a" = "ec1a"
    "eu-central-1b" = "ec1b"
    "eu-central-1c" = "ec1c"
    "eu-central-1d" = "ec1d"
    "eu-central-1e" = "ec1e"
    "eu-central-1f" = "ec1f"
    "eu-central-1g" = "ec1g"
    "eu-central-1h" = "ec1h"

    "eu-north-1"  = "en1"
    "eu-north-1a" = "en1a"
    "eu-north-1b" = "en1b"
    "eu-north-1c" = "en1c"
    "eu-north-1d" = "en1d"
    "eu-north-1e" = "en1e"
    "eu-north-1f" = "en1f"
    "eu-north-1g" = "en1g"
    "eu-north-1h" = "en1h"

    "eu-south-1"  = "es1"
    "eu-south-1a" = "es1a"
    "eu-south-1b" = "es1b"
    "eu-south-1c" = "es1c"
    "eu-south-1d" = "es1d"
    "eu-south-1e" = "es1e"
    "eu-south-1f" = "es1f"
    "eu-south-1g" = "es1g"
    "eu-south-1h" = "es1h"

    "eu-west-1"  = "ew1"
    "eu-west-1a" = "ew1a"
    "eu-west-1b" = "ew1b"
    "eu-west-1c" = "ew1c"
    "eu-west-1d" = "ew1d"
    "eu-west-1e" = "ew1e"
    "eu-west-1f" = "ew1f"
    "eu-west-1g" = "ew1g"
    "eu-west-1h" = "ew1h"

    "eu-west-2"  = "ew2"
    "eu-west-2a" = "ew2a"
    "eu-west-2b" = "ew2b"
    "eu-west-2c" = "ew2c"
    "eu-west-2d" = "ew2d"
    "eu-west-2e" = "ew2e"
    "eu-west-2f" = "ew2f"
    "eu-west-2g" = "ew2g"
    "eu-west-2h" = "ew2h"

    "eu-west-3"  = "ew3"
    "eu-west-3a" = "ew3a"
    "eu-west-3b" = "ew3b"
    "eu-west-3c" = "ew3c"
    "eu-west-3d" = "ew3d"
    "eu-west-3e" = "ew3e"
    "eu-west-3f" = "ew3f"
    "eu-west-3g" = "ew3g"
    "eu-west-3h" = "ew3h"

    "af-south-1"  = "fs1"
    "af-south-1a" = "fs1a"
    "af-south-1b" = "fs1b"
    "af-south-1c" = "fs1c"
    "af-south-1d" = "fs1d"
    "af-south-1e" = "fs1e"
    "af-south-1f" = "fs1f"
    "af-south-1g" = "fs1g"
    "af-south-1h" = "fs1h"

    "us-gov-east-1"  = "ge1"
    "us-gov-east-1a" = "ge1a"
    "us-gov-east-1b" = "ge1b"
    "us-gov-east-1c" = "ge1c"
    "us-gov-east-1d" = "ge1d"
    "us-gov-east-1e" = "ge1e"
    "us-gov-east-1f" = "ge1f"
    "us-gov-east-1g" = "ge1g"
    "us-gov-east-1h" = "ge1h"

    "us-gov-west-1"  = "gw1"
    "us-gov-west-1a" = "gw1a"
    "us-gov-west-1b" = "gw1b"
    "us-gov-west-1c" = "gw1c"
    "us-gov-west-1d" = "gw1d"
    "us-gov-west-1e" = "gw1e"
    "us-gov-west-1f" = "gw1f"
    "us-gov-west-1g" = "gw1g"
    "us-gov-west-1h" = "gw1h"

    "me-south-1"  = "ms1"
    "me-south-1a" = "ms1a"
    "me-south-1b" = "ms1b"
    "me-south-1c" = "ms1c"
    "me-south-1d" = "ms1d"
    "me-south-1e" = "ms1e"
    "me-south-1f" = "ms1f"
    "me-south-1g" = "ms1g"
    "me-south-1h" = "ms1h"

    "cn-north-1"  = "nn0"
    "cn-north-1a" = "nn0a"
    "cn-north-1b" = "nn0b"
    "cn-north-1c" = "nn0c"
    "cn-north-1d" = "nn0d"
    "cn-north-1e" = "nn0e"
    "cn-north-1f" = "nn0f"
    "cn-north-1g" = "nn0g"
    "cn-north-1h" = "nn0h"

    "cn-northwest-1"  = "nn1"
    "cn-northwest-1a" = "nn1a"
    "cn-northwest-1b" = "nn1b"
    "cn-northwest-1c" = "nn1c"
    "cn-northwest-1d" = "nn1d"
    "cn-northwest-1e" = "nn1e"
    "cn-northwest-1f" = "nn1f"
    "cn-northwest-1g" = "nn1g"
    "cn-northwest-1h" = "nn1h"

    "sa-east-1"  = "se1"
    "sa-east-1a" = "se1a"
    "sa-east-1b" = "se1b"
    "sa-east-1c" = "se1c"
    "sa-east-1d" = "se1d"
    "sa-east-1e" = "se1e"
    "sa-east-1f" = "se1f"
    "sa-east-1g" = "se1g"
    "sa-east-1h" = "se1h"

    "us-east-1"  = "ue1"
    "us-east-1a" = "ue1a"
    "us-east-1b" = "ue1b"
    "us-east-1c" = "ue1c"
    "us-east-1d" = "ue1d"
    "us-east-1e" = "ue1e"
    "us-east-1f" = "ue1f"
    "us-east-1g" = "ue1g"
    "us-east-1h" = "ue1h"

    "us-east-2"  = "ue2"
    "us-east-2a" = "ue2a"
    "us-east-2b" = "ue2b"
    "us-east-2c" = "ue2c"
    "us-east-2d" = "ue2d"
    "us-east-2e" = "ue2e"
    "us-east-2f" = "ue2f"
    "us-east-2g" = "ue2g"
    "us-east-2h" = "ue2h"

    "us-west-1"  = "uw1"
    "us-west-1a" = "uw1a"
    "us-west-1b" = "uw1b"
    "us-west-1c" = "uw1c"
    "us-west-1d" = "uw1d"
    "us-west-1e" = "uw1e"
    "us-west-1f" = "uw1f"
    "us-west-1g" = "uw1g"
    "us-west-1h" = "uw1h"

    "us-west-2"  = "uw2"
    "us-west-2a" = "uw2a"
    "us-west-2b" = "uw2b"
    "us-west-2c" = "uw2c"
    "us-west-2d" = "uw2d"
    "us-west-2e" = "uw2e"
    "us-west-2f" = "uw2f"
    "us-west-2g" = "uw2g"
    "us-west-2h" = "uw2h"

    "us-west-2-lax-1a" = "lx1a"
    "us-west-2-lax-1b" = "lx1b"
    "us-west-2-lax-1c" = "lx1c"
    "us-west-2-lax-1d" = "lx1d"
  }

  to_short = {
    "ap-east-1"  = "ape1"
    "ap-east-1a" = "ape1a"
    "ap-east-1b" = "ape1b"
    "ap-east-1c" = "ape1c"
    "ap-east-1d" = "ape1d"
    "ap-east-1e" = "ape1e"
    "ap-east-1f" = "ape1f"
    "ap-east-1g" = "ape1g"
    "ap-east-1h" = "ape1h"

    "ap-northeast-1"  = "apne1"
    "ap-northeast-1a" = "apne1a"
    "ap-northeast-1b" = "apne1b"
    "ap-northeast-1c" = "apne1c"
    "ap-northeast-1d" = "apne1d"
    "ap-northeast-1e" = "apne1e"
    "ap-northeast-1f" = "apne1f"
    "ap-northeast-1g" = "apne1g"
    "ap-northeast-1h" = "apne1h"

    "ap-northeast-2"  = "apne2"
    "ap-northeast-2a" = "apne2a"
    "ap-northeast-2b" = "apne2b"
    "ap-northeast-2c" = "apne2c"
    "ap-northeast-2d" = "apne2d"
    "ap-northeast-2e" = "apne2e"
    "ap-northeast-2f" = "apne2f"
    "ap-northeast-2g" = "apne2g"
    "ap-northeast-2h" = "apne2h"

    "ap-south-1"  = "aps1"
    "ap-south-1a" = "aps1a"
    "ap-south-1b" = "aps1b"
    "ap-south-1c" = "aps1c"
    "ap-south-1d" = "aps1d"
    "ap-south-1e" = "aps1e"
    "ap-south-1f" = "aps1f"
    "ap-south-1g" = "aps1g"
    "ap-south-1h" = "aps1h"

    "ap-southeast-1"  = "apse1"
    "ap-southeast-1a" = "apse1a"
    "ap-southeast-1b" = "apse1b"
    "ap-southeast-1c" = "apse1c"
    "ap-southeast-1d" = "apse1d"
    "ap-southeast-1e" = "apse1e"
    "ap-southeast-1f" = "apse1f"
    "ap-southeast-1g" = "apse1g"
    "ap-southeast-1h" = "apse1h"

    "ap-southeast-2"  = "apse2"
    "ap-southeast-2a" = "apse2a"
    "ap-southeast-2b" = "apse2b"
    "ap-southeast-2c" = "apse2c"
    "ap-southeast-2d" = "apse2d"
    "ap-southeast-2e" = "apse2e"
    "ap-southeast-2f" = "apse2f"
    "ap-southeast-2g" = "apse2g"
    "ap-southeast-2h" = "apse2h"

    "ca-central-1"  = "cac1"
    "ca-central-1a" = "cac1a"
    "ca-central-1b" = "cac1b"
    "ca-central-1c" = "cac1c"
    "ca-central-1d" = "cac1d"
    "ca-central-1e" = "cac1e"
    "ca-central-1f" = "cac1f"
    "ca-central-1g" = "cac1g"
    "ca-central-1h" = "cac1h"

    "eu-central-1"  = "euc1"
    "eu-central-1a" = "euc1a"
    "eu-central-1b" = "euc1b"
    "eu-central-1c" = "euc1c"
    "eu-central-1d" = "euc1d"
    "eu-central-1e" = "euc1e"
    "eu-central-1f" = "euc1f"
    "eu-central-1g" = "euc1g"
    "eu-central-1h" = "euc1h"

    "eu-north-1"  = "eun1"
    "eu-north-1a" = "eun1a"
    "eu-north-1b" = "eun1b"
    "eu-north-1c" = "eun1c"
    "eu-north-1d" = "eun1d"
    "eu-north-1e" = "eun1e"
    "eu-north-1f" = "eun1f"
    "eu-north-1g" = "eun1g"
    "eu-north-1h" = "eun1h"

    "eu-south-1"  = "eus1"
    "eu-south-1a" = "eus1a"
    "eu-south-1b" = "eus1b"
    "eu-south-1c" = "eus1c"
    "eu-south-1d" = "eus1d"
    "eu-south-1e" = "eus1e"
    "eu-south-1f" = "eus1f"
    "eu-south-1g" = "eus1g"
    "eu-south-1h" = "eus1h"

    "eu-west-1"  = "euw1"
    "eu-west-1a" = "euw1a"
    "eu-west-1b" = "euw1b"
    "eu-west-1c" = "euw1c"
    "eu-west-1d" = "euw1d"
    "eu-west-1e" = "euw1e"
    "eu-west-1f" = "euw1f"
    "eu-west-1g" = "euw1g"
    "eu-west-1h" = "euw1h"

    "eu-west-2"  = "euw2"
    "eu-west-2a" = "euw2a"
    "eu-west-2b" = "euw2b"
    "eu-west-2c" = "euw2c"
    "eu-west-2d" = "euw2d"
    "eu-west-2e" = "euw2e"
    "eu-west-2f" = "euw2f"
    "eu-west-2g" = "euw2g"
    "eu-west-2h" = "euw2h"

    "eu-west-3"  = "euw3"
    "eu-west-3a" = "euw3a"
    "eu-west-3b" = "euw3b"
    "eu-west-3c" = "euw3c"
    "eu-west-3d" = "euw3d"
    "eu-west-3e" = "euw3e"
    "eu-west-3f" = "euw3f"
    "eu-west-3g" = "euw3g"
    "eu-west-3h" = "euw3h"

    "af-south-1"  = "afs1"
    "af-south-1a" = "afs1a"
    "af-south-1b" = "afs1b"
    "af-south-1c" = "afs1c"
    "af-south-1d" = "afs1d"
    "af-south-1e" = "afs1e"
    "af-south-1f" = "afs1f"
    "af-south-1g" = "afs1g"
    "af-south-1h" = "afs1h"

    "us-gov-east-1"  = "usge1"
    "us-gov-east-1a" = "usge1a"
    "us-gov-east-1b" = "usge1b"
    "us-gov-east-1c" = "usge1c"
    "us-gov-east-1d" = "usge1d"
    "us-gov-east-1e" = "usge1e"
    "us-gov-east-1f" = "usge1f"
    "us-gov-east-1g" = "usge1g"
    "us-gov-east-1h" = "usge1h"

    "us-gov-west-1"  = "usgw1"
    "us-gov-west-1a" = "usgw1a"
    "us-gov-west-1b" = "usgw1b"
    "us-gov-west-1c" = "usgw1c"
    "us-gov-west-1d" = "usgw1d"
    "us-gov-west-1e" = "usgw1e"
    "us-gov-west-1f" = "usgw1f"
    "us-gov-west-1g" = "usgw1g"
    "us-gov-west-1h" = "usgw1h"

    "me-south-1"  = "mes1"
    "me-south-1a" = "mes1a"
    "me-south-1b" = "mes1b"
    "me-south-1c" = "mes1c"
    "me-south-1d" = "mes1d"
    "me-south-1e" = "mes1e"
    "me-south-1f" = "mes1f"
    "me-south-1g" = "mes1g"
    "me-south-1h" = "mes1h"

    "cn-north-1"  = "cnn1"
    "cn-north-1a" = "cnn1a"
    "cn-north-1b" = "cnn1b"
    "cn-north-1c" = "cnn1c"
    "cn-north-1d" = "cnn1d"
    "cn-north-1e" = "cnn1e"
    "cn-north-1f" = "cnn1f"
    "cn-north-1g" = "cnn1g"
    "cn-north-1h" = "cnn1h"

    "cn-northwest-1"  = "cnnw1"
    "cn-northwest-1a" = "cnnw1a"
    "cn-northwest-1b" = "cnnw1b"
    "cn-northwest-1c" = "cnnw1c"
    "cn-northwest-1d" = "cnnw1d"
    "cn-northwest-1e" = "cnnw1e"
    "cn-northwest-1f" = "cnnw1f"
    "cn-northwest-1g" = "cnnw1g"
    "cn-northwest-1h" = "cnnw1h"

    "sa-east-1"  = "sae1"
    "sa-east-1a" = "sae1a"
    "sa-east-1b" = "sae1b"
    "sa-east-1c" = "sae1c"
    "sa-east-1d" = "sae1d"
    "sa-east-1e" = "sae1e"
    "sa-east-1f" = "sae1f"
    "sa-east-1g" = "sae1g"
    "sa-east-1h" = "sae1h"

    "us-east-1"  = "use1"
    "us-east-1a" = "use1a"
    "us-east-1b" = "use1b"
    "us-east-1c" = "use1c"
    "us-east-1d" = "use1d"
    "us-east-1e" = "use1e"
    "us-east-1f" = "use1f"
    "us-east-1g" = "use1g"
    "us-east-1h" = "use1h"

    "us-east-2"  = "use2"
    "us-east-2a" = "use2a"
    "us-east-2b" = "use2b"
    "us-east-2c" = "use2c"
    "us-east-2d" = "use2d"
    "us-east-2e" = "use2e"
    "us-east-2f" = "use2f"
    "us-east-2g" = "use2g"
    "us-east-2h" = "use2h"

    "us-west-1"  = "usw1"
    "us-west-1a" = "usw1a"
    "us-west-1b" = "usw1b"
    "us-west-1c" = "usw1c"
    "us-west-1d" = "usw1d"
    "us-west-1e" = "usw1e"
    "us-west-1f" = "usw1f"
    "us-west-1g" = "usw1g"
    "us-west-1h" = "usw1h"

    "us-west-2"  = "usw2"
    "us-west-2a" = "usw2a"
    "us-west-2b" = "usw2b"
    "us-west-2c" = "usw2c"
    "us-west-2d" = "usw2d"
    "us-west-2e" = "usw2e"
    "us-west-2f" = "usw2f"
    "us-west-2g" = "usw2g"
    "us-west-2h" = "usw2h"

    "us-west-2-lax-1a" = "lax1a"
    "us-west-2-lax-1b" = "lax1b"
    "us-west-2-lax-1c" = "lax1c"
    "us-west-2-lax-1d" = "lax1d"
  }

  from_fixed = zipmap(values(local.to_fixed), keys(local.to_fixed))
  from_short = zipmap(values(local.to_short), keys(local.to_short))
}
