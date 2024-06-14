param env string
param location string
var webAppServerFarmName = 'webApp-serverFarm-${env}'
var webAppSiteName = 'webApp-${env}'

resource webAppServerFarm 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: webAppServerFarmName
  location: location
  kind: 'app'
  properties: {}
  sku: {
    name: 'S1'
    tier: 'Standard'
    size: 'S1'
    family: 'S'
    capacity: 1
  }
}

output webAppServerFarmId string = webAppServerFarm.id


resource webAppSite 'Microsoft.Web/sites@2021-03-01' = {
  name: webAppSiteName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: webAppServerFarm.id
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: true
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 0
      defaultDocuments: [
        'Default.htm'
        'Default.html'
        'Default.asp'
        'index.htm'
        'index.html'
        'iisstart.htm'
        'default.aspx'
        'index.php'
        'hostingstart.html'
      ]
      virtualApplications: [
        {
          virtualPath: '/'
          physicalPath: 'site\\wwwroot'
          preloadEnabled: true
        }
      ]
      netFrameworkVersion: 'v4.0'
      loadBalancing: 'LeastRequests'
      nodeVersion: '~14'
      autoHealEnabled: false
      vnetRouteAllEnabled: false
      vnetPrivatePortsCount: 0
      localMySqlEnabled: false
      scmIpSecurityRestrictionsUseMain: false
      http20Enabled: false
      minTlsVersion: '1.2'
      scmMinTlsVersion: '1.2'
      ipSecurityRestrictions: [
        {
          ipAddress: 'Any'
          action: 'Allow'
          priority: 1
          name: 'Allow all'
          description: 'Allow all access'
        }
      ]
      scmIpSecurityRestrictions: [
        {
          ipAddress: 'Any'
          action: 'Allow'
          priority: 1
          name: 'Allow all'
          description: 'Allow all access'
        }
      ]
      ftpsState: 'Disabled'
    }
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
    storageAccountRequired: false
  }
}
