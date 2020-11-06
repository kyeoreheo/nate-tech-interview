import { schema } from 'nexus'

export const Product = schema.objectType({
  name: 'Product',
  definition(t) {
    t.model.id()
    t.model.createdAt()
    t.model.updatedAt()
    t.model.title()
    t.model.images()
    t.model.url()
    t.model.merchant()
    // t.model.purchases()
  }
})

// export const Purchase = schema.objectType({
//   name: 'Purchase',
//   definition(t) {
//     t.model.id()
//     t.model.createdAt()
//     t.model.updatedAt()
//     t.model.price()
//     t.model.productId()
//     t.model.product()
//   }
// })
