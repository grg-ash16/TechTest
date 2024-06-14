param env string
param location string
var serviceBusName = 'service-bus-${env}'

resource serviceBus 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: serviceBusName
  location: location
  tags: {
    displayName: 'service bus'
  }
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
  }
}

resource serviceBusSharedAccessKey 'Microsoft.ServiceBus/namespaces/AuthorizationRules@2022-01-01-preview' = {
  name: '${serviceBusName}/RootManageSharedAccessKey'
  properties: {
    rights: [
      'Listen'
      'Manage'
      'Send'
    ]
  }
  dependsOn: [
    serviceBus
  ]
}
