﻿Describe 'Run-AlPipeline' {
    It 'Run-AlPipeline' {
        $baseFolder = Join-Path $PSScriptRoot "helloworld"
        $resultsFile = Join-Path $baseFolder "result.xml"
        $buildArtifactFolder = Join-Path $baseFolder "buildArtifactFolder"
        $outputFolder = Join-Path $baseFolder "output"
        Remove-Item $resultsFile -Force -ErrorAction SilentlyContinue
        Remove-Item $buildArtifactFolder -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item $outputFolder -Recurse -Force -ErrorAction SilentlyContinue

        Run-AlPipeline `
            -pipelineName nch `
            -baseFolder $baseFolder `
            -licenseFile $buildlicenseFile `
            -containerName nchbuild `
            -credential $credential `
            -installApps @("https://businesscentralapps.blob.core.windows.net/hidestuff/latest/hidestuff-apps.zip") `
            -appFolders "app,base" `
            -testFolders @("test") `
            -previousApps @("https://businesscentralapps.blob.core.windows.net/hidestuff/2.0.11036.0/hidestuff-apps.zip") `
            -additionalCountries "dk,de" `
            -appBuild ([int32]::MaxValue) `
            -appRevision 0 `
            -testResultsFile $resultsFile `
            -testResultsFormat JUnit `
            -artifact "///us/Current" `
            -imageName '' `
            -outputFolder $outputFolder `
            -buildArtifactFolder $buildArtifactFolder `
            -createRuntimePackages `
            -installTestFramework `
            -gitHubActions `
            -enablePerTenantExtensionCop

        Remove-Item $resultsFile -Force -ErrorAction SilentlyContinue
        Remove-Item $buildArtifactFolder -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item $outputFolder -Recurse -Force -ErrorAction SilentlyContinue
    }
}
