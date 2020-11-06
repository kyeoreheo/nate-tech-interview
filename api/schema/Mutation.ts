import { schema } from 'nexus'

schema.mutationType({
  definition(t) {
    // Product
    t.crud.createOneProduct()
    t.crud.updateOneProduct()
    t.crud.upsertOneProduct()
    t.crud.deleteOneProduct()
  }
})
