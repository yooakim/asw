param name string = 'myfirstswadeployment'
param location string = resourceGroup().location
param sku string = 'Free'
param skucode string = 'Free'
param repositoryUrl string = 'https://github.com/yooakim/asw.git'
param branch string = 'main'

@secure()
param repositoryToken string = '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'
param appLocation string = '/'
param apiLocation string = ''
param appArtifactLocation string = 'src'
param resourceTags object = {
  Environment: 'Development'
  Project: 'Testing SWA with ARM'
  ApplicationName: 'myfirstswadeployment'
}
param appSettings object = {
  MY_APP_SETTING1: 'value 1'
  MY_APP_SETTING2: 'value 2'
}

resource name_resource 'Microsoft.Web/staticSites@2021-01-15' = {
  name: name
  location: location
  tags: resourceTags
  properties: {
    repositoryUrl: repositoryUrl
    branch: branch
    repositoryToken: repositoryToken
    buildProperties: {
      appLocation: appLocation
      apiLocation: apiLocation
      appArtifactLocation: appArtifactLocation
    }
  }
  sku: {
    tier: sku
    name: skucode
  }
}

resource name_appsettings 'Microsoft.Web/staticSites/config@2021-01-15' = {
  parent: name_resource
  name: 'appsettings'
  location: location
  properties: appSettings
}
