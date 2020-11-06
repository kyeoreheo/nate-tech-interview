import { schema } from 'nexus'

const options = { filtering: true, ordering: true, pagination: true }

schema.queryType({
  definition(t) {
    // Product
    t.crud.product()
    t.crud.products(options)
  }
})
