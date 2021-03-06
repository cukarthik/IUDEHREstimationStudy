# Copyright 2019 Observational Health Data Sciences and Informatics
#
# This file is part of IUDEHRStudy
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Submit the study results to the study coordinating center
#'
#' @details
#' This will upload the file \code{StudyResults.zip} to the study coordinating center using Amazon S3.
#' This requires an active internet connection.
#'
#' @param outputFolder   Name of local folder where the results were generated; make sure to use forward slashes
#'                       (/). Do not use a folder on a network drive since this greatly impacts
#'                       performance.
#' @param userName       The username used to submit resutls to the study coordinator
#' @param privateKeyFile         The private key as provided by the study coordinator
#'
#' @return
#' TRUE if the upload was successful.
#'
#' @export
submitResults <- function(outputFolder, fileName, userName, privateKeyFile) {
  zipName <- file.path(outputFolder, fileName)
  if (!file.exists(zipName)) {
    stop(paste("Cannot find file", zipName))
  }
  writeLines(paste0("Uploading file '", zipName, "' to study coordinating center"))
  result <- OhdsiSharing::sftpUploadFile(privateKeyFileName = privateKeyFile, 
                                         userName = userName, 
                                         fileName = zipName)
  if (result) {
    writeLines("Upload complete")
  } else {
    writeLines("Upload failed. Please contact the study coordinator")
  }
  invisible(result)
}
