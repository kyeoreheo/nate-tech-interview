import express from 'express'
import bodyParser from 'body-parser'

import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

const app = express()

app.use(bodyParser.json())

app.post('/products', async (req, res) => {
  const { where } = req.body
  try {
    const posts = await prisma.product.findMany({ where, orderBy: { createdAt: 'desc' } })
    res.json({ posts: posts || [] })
  } catch (error) {
    console.error(error)
    res.status(500).json({})
  }
})

app.post('/products/offset', async (req, res) => {
  const { skip, take, where } = req.body
  try {
    const posts = await prisma.product.findMany({
      skip: Number(skip),
      take: Number(take),
      where,
      orderBy: { createdAt: 'desc' }
    })
    res.json({ posts: posts || [] })
  } catch (error) {
    console.error(error)
    res.status(500).json({})
  }
})

app.post('/products/cursor', async (req, res) => {
  const { cursor, take, where } = req.body
  try {
    const posts = await prisma.product.findMany({
      cursor,
      take: Number(take),
      where,
      orderBy: { createdAt: 'desc' }
    })
    res.json(posts)
  } catch (error) {
    console.error(error)
    res.status(500).json({})
  }
})

app.get(`/product/:id`, async (req, res) => {
  const { id } = req.params
  try {
    const post = await prisma.product.findOne({ where: { id } })
    res.json({ post: post || {} })
  } catch (error) {
    console.error(error)
    res.status(500).json({})
  }
})

app.post('/product/create', async (req, res) => {
  const { title, images, url, merchant } = req.body
  try {
    const posts = await prisma.product.create({
      data: {
        title: title as string | undefined,
        images: images != null ? { set: images as string[] | undefined } : undefined,
        url: url as string | undefined,
        merchant: merchant as string | undefined
      }
    })
    res.json(posts)
  } catch (error) {
    console.error(error)
    res.status(500).json({})
  }
})

app.post('/product/update', async (req, res) => {
  const { id, title, images, url, merchant } = req.body
  try {
    const posts = await prisma.product.update({
      where: { id: id as string | undefined },
      data: {
        title: title as string | undefined,
        images: images != null ? { set: images as string[] | undefined } : undefined,
        url: url as string | undefined,
        merchant: merchant as string | undefined
      }
    })
    res.json(posts)
  } catch (error) {
    console.error(error)
    res.status(500).json({})
  }
})

app.post('/product/delete', async (req, res) => {
  const { id } = req.body
  try {
    const posts = await prisma.product.delete({ where: { id: id as string | undefined } })
    res.json(posts)
  } catch (error) {
    console.error(error)
    res.status(500).json({})
  }
})

app.listen(3000, () => console.log('🚀 Server ready at: http://localhost:3000'))
