# 1 must install reticulate rgee, remotes and googledrive

# 2 Load reticulate and rgee
library("reticulate")
library("rgee") 
library("googledrive")
library("googleCloudStorageR")

# 3 use rgee to install the needed python packages to interface with gee
rgee::ee_install()

# 4 Install gcloud
# https://cloud.google.com/sdk/docs/install
# When installing the projectname is provided in the command line that opens automatically

# 5 check non-R dependencies
ee_check()
#NOTE: The Earth Engine Python API version 0.1.357 is installed
#correctly in the system but rgee was tested using the version
#0.1.323. To avoid possible issues, we recommend install the
#version used by rgee (0.1.323). You might use:
#* rgee::ee_install_upgrade()
#* reticulate::py_install('earthengine-api==0.1.323', envname='PUT_HERE_YOUR_PYENV')
#* pip install earthengine-api==0.1.323 (Linux and Mac0S)
#* conda install earthengine-api==0.1.323 (Linux, Mac0S, and Windows)

rgee::ee_install_upgrade() 
# We needed to run this because it was giving problems for the initialization

# 6 set credentials
projectname <- 'ee-martabonato91'
my_email <- 'marta.bonato91@gmail.com'
ee_Initialize(user = my_email, drive = T, gcs = F)  # initially gcs = T
# C:\Users\bonato\AppData\Roaming\gcloud\application_default_credentials.json

#Unable to find a service account key (SAK) file in: C:\Users\bonato/.config/earthengine//marta.bonato91
#Please, download and save the key manually on the path mentioned
#before. A compressible tutorial to obtain their SAK file is available in:
 # > https://r-spatial.github.io/rgee/articles/rgee05.html

# 7 Optionally set a service account key (SAK)
# https://r-spatial.github.io/rgee/articles/rgee05.html

# 8 optionally remove credentials of current user
# ee_clean_credentials()


