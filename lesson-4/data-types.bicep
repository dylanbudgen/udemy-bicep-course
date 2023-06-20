
// secure parameters

@secure()
param password string

// strings

var exampleString = 'string-example'
var exampleStringTwo = 'another-${exampleString}'
var multilineString = '''
demo'''

// integers

var exampleInteger = 100323

// booleans

var exampleBoolean = true
var exampleBooleanTwo = false

// arrays

var array = [
  'value1'
  'value2'
]

var arrayValue = array[0]

var mixedArray = [
  'value1'
  2
  'value3'
]

var joinedArray = union(array, mixedArray)

// objects

var object = {
  name: 'Dylan'
  number: 07812312312
  postcode: 'SE00000'
}

var tags = {
  environment: 'dev'
  owner: 'Dylan Budgen'
}

var environment = tags.environment

var joinedObjects = union(object, tags)

var storageAccountConfig = {
  sku: 'Standard_LRS'
  kind: 'StorageV2'
}

var nestedObject = {
  value: {
    value: 1
  }
  value2: [
    'value'
  ]
}

var nestedOjectValue = nestedObject.value2[0]
