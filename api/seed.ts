import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

const seed = async (): Promise<void> => {
  // Reset

  await prisma.product.deleteMany({ where: {} })

  // Create

  // prisma.product.create({
  //   data: {
  //     title: "",
  //     images: { set: [] },
  //     url: "",
  //     merchant: ""
  //   }
  // })

  await prisma.product.create({
    data: {
      title: "Men's Wool Runners",
      images: {
        set: [
          'https://cdn.allbirds.com/image/fetch/q_auto,f_auto/w_1000,f_auto,q_auto,b_rgb:f5f5f5/https://cdn.shopify.com/s/files/1/0074/1307/1990/products/Allbirds_WL_RN_SF_PDP_Natural_Grey_BTY_21b1041c-f9ef-4efe-853d-4d3ea4925c48.png?v=1589226918',
          'https://cdn.allbirds.com/image/fetch/q_auto,f_auto/w_1000,f_auto,q_auto,b_rgb:f5f5f5/https://cdn.shopify.com/s/files/1/0074/1307/1990/products/Allbirds_WL_RN_SF_PDP_Natural_Grey_LAT_d5276b4f-c166-4106-a052-5ed37e101e56.png?v=1589226918',
          'https://cdn.allbirds.com/image/fetch/q_auto,f_auto/w_1000,f_auto,q_auto,b_rgb:f5f5f5/https://cdn.shopify.com/s/files/1/0074/1307/1990/products/Allbirds_WL_RN_SF_PDP_Natural_Grey_MED_9ae17770-7706-4b17-a73f-fb64ecf2152c.png?v=1589226918',
          'https://cdn.allbirds.com/image/fetch/q_auto,f_auto/w_1000,f_auto,q_auto,b_rgb:f5f5f5/https://cdn.shopify.com/s/files/1/0074/1307/1990/products/Allbirds_WL_RN_SF_PDP_Natural_Grey_HEL_bd2d53fb-9839-4c50-9b9f-fb607d59d6fd.png?v=1589226918',
          'https://cdn.allbirds.com/image/fetch/q_auto,f_auto/w_1000,f_auto,q_auto,b_rgb:f5f5f5/https://cdn.shopify.com/s/files/1/0074/1307/1990/products/Allbirds_WL_RN_SF_PDP_Natural_Grey_TOP_ee258694-c30c-4caf-87cd-4fb863a09c4b.png?v=1589226918',
          'https://cdn.allbirds.com/image/fetch/q_auto,f_auto/w_1000,f_auto,q_auto,b_rgb:f5f5f5/https://cdn.shopify.com/s/files/1/0074/1307/1990/products/Allbirds_WL_RN_SF_PDP_Natural_Grey_OUT_e67aa244-d8a6-4fad-8693-8c537b263e93.png?v=1589226918',
          'https://cdn.allbirds.com/image/fetch/q_auto,f_auto/w_1000,f_auto,q_auto,b_rgb:f5f5f5/https://cdn.shopify.com/s/files/1/0074/1307/1990/products/Allbirds_WL_RN_SF_PDP_Natural_Grey_PAIR_000d704e-3ffe-4e81-8aea-0d04acfec8e5.png?v=1589226918',
          'https://cdn.allbirds.com/image/fetch/q_auto,f_auto/w_1000,f_auto,q_auto,b_rgb:f5f5f5/https://cdn.shopify.com/s/files/1/0074/1307/1990/products/Allbirds_M_RUNNER_HP_GRID_1600x1600_2aa182f9-ff90-494e-a471-1d30e73581ad.jpg?v=1589226918'
        ]
      },
      url: 'https://www.allbirds.co.uk/products/mens-wool-runners',
      merchant: 'allbirds'
    }
  })

  await prisma.product.create({
    data: {
      title: 'iPhone 11',
      images: {
        set: [
          'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone11-gallery1-2019?wid=3360&hei=1280&fmt=png-alpha&qlt=80&.v=1567280206009'
        ]
      },
      url: 'https://www.apple.com/us/shop/buy-iphone/iphone-11',
      merchant: ''
    }
  })

  await prisma.product.create({
    data: {
      title: '',
      images: {
        set: [
          'https://cdn.shopify.com/s/files/1/0050/7674/6329/products/Herbivore-CoconutBathSoak-16oz_600x.jpg?v=1595445713',
          'https://cdn.shopify.com/s/files/1/0050/7674/6329/products/Herbivore-CoconutBathSoak_600x.jpg?v=1590072456'
        ]
      },
      url: 'https://standarddose.com/collections/all-products/products/herbivore-botanicals-coconut-bath-soak',
      merchant: 'STANDARD DOSE'
    }
  })

  await prisma.product.create({
    data: {
      title:
        'king do way Insulated Stainless Steel Water Vacuum Bottle Flask Double-Walled with a Brush for Outdoor Sports Hiking Running, 500ml /18 oz',
      images: {
        set: [
          'https://images-na.ssl-images-amazon.com/images/I/61ZSjBoo7TL._AC_SX679_.jpg',
          '',
          'https://images-na.ssl-images-amazon.com/images/I/61D920jUggL._AC_SX679_.jpg'
        ]
      },
      url: '',
      merchant: 'Amazon'
    }
  })

  await prisma.product.create({
    data: {
      title: '',
      images: { set: ['none'] },
      url:
        'https://www.walmart.com/ip/Hamilton-Beach-The-Scoop-Single-Serve-Coffee-Maker-Single-Serve-Brewer-14-oz-Stainless-Steel-47550/911356214',
      merchant: 'Walmart'
    }
  })

  await prisma.product.create({
    data: {
      title: "Women's Solid Neon Tipping Ankle Socks",
      images: {
        set: [
          'http://cdn.shopify.com/s/files/1/1119/5850/products/hot-pink-grid_b0f646f8-97ff-4989-bffc-c26a1c4a2d2a_1024x1024.jpg?v=1595855762',
          'http://cdn.shopify.com/s/files/1/1119/5850/products/blackberry-layflat-product-transparent_bcbf5f77-acbb-498f-87e6-851917e7f78b_1024x1024.png?v=1595855762',
          'http://cdn.shopify.com/s/files/1/1119/5850/products/hot-pink-laylfat-product-transparent_1024x1024.png?v=1595855762',
          'https://cdn.shopify.com/s/files/1/1119/5850/products/hot-pink-grid_b0f646f8-97ff-4989-bffc-c26a1c4a2d2a_1024x1024.jpg?v=1595855762',
          'https://cdn.shopify.com/s/files/1/1119/5850/products/blackberry-layflat-product-transparent_bcbf5f77-acbb-498f-87e6-851917e7f78b_1024x1024.png?v=1595855762',
          'https://cdn.shopify.com/s/files/1/1119/5850/products/hot-pink-laylfat-product-transparent_1024x1024.png?v=1595855762'
        ]
      },
      url: 'https://bombas.com/products/womens-solid-neon-tipping-ankle-socks?variant=blackberry&size=m',
      merchant: 'Bombas'
    }
  })

  await prisma.product.create({
    data: {
      title: 'Juan Soto Washington Nationals Nike Youth 2020 Gold Program Replica Player Jersey - White/Gold',
      images: {
        set: [
          'https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3802000/ff_3802240-4b85edcce601a42d6641_full.jpg'
        ]
      },
      url:
        'https://www.fanatics.com/mlb/washington-nationals/juan-soto-washington-nationals-nike-youth-2020-gold-program-replica-player-jersey-white/gold/o-7887+t-58234569+p-8153449092+z-8-1618303961?_ref=p-CLP:m-GRID:i-r4c0:po-12',
      merchant: 'Fanatics'
    }
  })

  await prisma.product.create({
    data: {
      title: "Women's Solids Ankle Socks",
      images: {
        set: [
          'http://cdn.shopify.com/s/files/1/1119/5850/products/white-grid_a6907af6-5150-4ff6-a55c-26211e872e86_1024x1024.jpg?v=1591036263' +
            'http://cdn.shopify.com/s/files/1/1119/5850/products/navy-grid_1aa351eb-00ba-4600-b984-23b803f880c8_1024x1024.jpg?v=1591036263' +
            'http://cdn.shopify.com/s/files/1/1119/5850/products/navy-layflat-product_f55adef8-7df7-4438-b588-f0de39aeba9d_1024x1024.jpg?v=1591036263' +
            'https://cdn.shopify.com/s/files/1/1119/5850/products/white-grid_a6907af6-5150-4ff6-a55c-26211e872e86_1024x1024.jpg?v=1591036263' +
            'https://cdn.shopify.com/s/files/1/1119/5850/products/navy-grid_1aa351eb-00ba-4600-b984-23b803f880c8_1024x1024.jpg?v=1591036263' +
            'https://cdn.shopify.com/s/files/1/1119/5850/products/navy-layflat-product_f55adef8-7df7-4438-b588-f0de39aeba9d_1024x1024.jpg?v=1591036263'
        ]
      },
      url: 'https://bombas.com/products/women-s-solid-ankle-sock-white-medium?variant=white&size=m',
      merchant: 'Bombas'
    }
  })

  await prisma.product.create({
    data: {
      title: 'Gobi II Mens',
      images: { set: ['https://www.vivobarefoot.com/userdata/root/images/products/mens/gobi/200042-13z_01_wr.jpg'] },
      url: 'https://www.vivobarefoot.com/us/mens/everyday/gobi-ii-mens?colour=Brown',
      merchant: 'Vivo Barefoot'
    }
  })

  await prisma.product.create({
    data: {
      title: 'Primus Trail FG Womens',
      images: {
        set: ['https://www.vivobarefoot.com/userdata/root/images/products/mens/primus-trail-fg/w_200174-01_side.jpg']
      },
      url: 'https://www.vivobarefoot.com/us/womens/outdoor/primus-trail-fg-womens-ow1?colour=Obsidian',
      merchant: 'Vivo Barefoot'
    }
  })

  await prisma.product.create({
    data: {
      title: 'Wild Rose & Berry Lip Butter',
      images: {
        set: [
          'https://www.burtsbees.com/dw/image/v2/AAPA_PRD/on/demandware.static/-/Sites-burtsbees-master-catalog/default/dw80d6ce90/images/large/792850910638.jpg?sw=380&sh=380&sm=fit'
        ]
      },
      url: 'https://www.burtsbees.com/product/wild-rose-and-berry-lip-butter/792850910645.html',
      merchant: "Burt's Bees"
    }
  })

  await prisma.product.create({
    data: {
      title: 'Lavender & Honey Lip Butter',
      images: {
        set: [
          'https://www.burtsbees.com/dw/image/v2/AAPA_PRD/on/demandware.static/-/Sites-burtsbees-master-catalog/default/dwa8267b1b/images/large/792850902398.jpg?sw=380&sh=380&sm=fit'
        ]
      },
      url: 'https://www.burtsbees.com/product/lavender-and-honey-lip-butter/792850902398.html',
      merchant: "Burt's Bees"
    }
  })

  await prisma.product.create({
    data: {
      title: 'Air - Air Purifier for large rooms',
      images: {
        set: [
          'https://images.prismic.io/molekule/4720c1c9-23fa-4ffe-8171-f2cd988ebac0_SEO+-+Air.png?auto=compress,format&max-w=1200&max-h=1200&fit=crop'
        ]
      },
      url: 'https://molekule.com/air-purifier-air',
      merchant: 'Molekule'
    }
  })

  await prisma.product.create({
    data: {
      title: 'Island Punch Bath Bomb',
      images: { set: ['https://www.oldwhalingcompany.com/mm5/graphics/00000001/Island-Punch-Bath-Bomb-POW-960.png'] },
      url: 'https://www.oldwhalingcompany.com/old-whaling-company-island-punch-bath-bomb.html',
      merchant: 'www.oldwhalingcompany.com'
    }
  })

  await prisma.product.create({
    data: {
      title: 'Island Punch Candle',
      images: { set: ['https://www.oldwhalingcompany.com/mm5/graphics/00000001/Island_Punch_Candle_POW_960.png'] },
      url: 'https://www.oldwhalingcompany.com/island-punch-candle.html',
      merchant: 'www.oldwhalingcompany.com'
    }
  })

  await prisma.product.create({
    data: {
      title: 'The Into You Set',
      images: {
        set: [
          'http://cdn.shopify.com/s/files/1/2665/7478/products/PDP-OJ_wedding_0306203317_R2_TopCoat2-newyellow_1200x1200.jpg?v=1589409163'
        ]
      },
      url: 'https://oliveandjune.com/products/into-you-collection-1',
      merchant: 'Olive and June'
    }
  })

  await prisma.product.create({
    data: {
      title: 'Grateful & Kind',
      images: {
        set: [
          'http://cdn.shopify.com/s/files/1/2665/7478/products/Pink-OJ_VidStills_061119_5863_R1_1200x1200.jpg?v=1589181156' +
            'http://cdn.shopify.com/s/files/1/2665/7478/products/Pink-OJ_VidStills_061119_5667_R1_1200x1200.jpg?v=1589181156' +
            'http://cdn.shopify.com/s/files/1/2665/7478/products/Pink-Photo-Feb-01_-6-42-48-PM_1200x1200.jpg?v=1589181156' +
            'https://cdn.shopify.com/s/files/1/2665/7478/products/Pink-OJ_VidStills_061119_5863_R1_1200x1200.jpg?v=1589181156' +
            'https://cdn.shopify.com/s/files/1/2665/7478/products/Pink-OJ_VidStills_061119_5667_R1_1200x1200.jpg?v=1589181156' +
            'https://cdn.shopify.com/s/files/1/2665/7478/products/Pink-Photo-Feb-01_-6-42-48-PM_1200x1200.jpg?v=1589181156'
        ]
      },
      url: 'https://oliveandjune.com/products/grateful-kind',
      merchant: 'Olive and June'
    }
  })

  await prisma.product.create({
    data: {
      title: '',
      images: {
        set: [
          'http://cdn.shopify.com/s/files/1/1491/5166/products/CTH-BLK_grande.jpg?v=1573607160' +
            'https://cdn.shopify.com/s/files/1/1491/5166/products/CTH-BLK_grande.jpg?v=1573607160',
          'http://cdn.shopify.com/s/files/1/1491/5166/products/xx_02749_grande.jpg?v=1573607164',
          'https://cdn.shopify.com/s/files/1/1491/5166/products/xx_02749_grande.jpg?v=1573607164',
          'http://cdn.shopify.com/s/files/1/1491/5166/products/xx_02772_grande.jpg?v=1573607182',
          'https://cdn.shopify.com/s/files/1/1491/5166/products/xx_02772_grande.jpg?v=1573607182'
        ]
      },
      url: 'https://unboundmerino.com/collections/sweaters/products/compact-travel-hoodie',
      merchant: 'Unbound Merino'
    }
  })

  await prisma.product.create({
    data: {
      title: '3 Pack // Merino All Season Crew Socks',
      images: {
        set: [
          'http://cdn.shopify.com/s/files/1/1491/5166/products/CrewSockPack_x3_76539edc-3c35-42e6-9eba-25acb643e4bc_grande.jpg?v=1594243084',
          'https://cdn.shopify.com/s/files/1/1491/5166/products/CrewSockPack_x3_76539edc-3c35-42e6-9eba-25acb643e4bc_grande.jpg?v=1594243084',
          'http://cdn.shopify.com/s/files/1/1491/5166/products/LS_9020_56b70f56-f530-40ec-8ffe-960c10771d07_grande.jpg?v=1594243084',
          'https://cdn.shopify.com/s/files/1/1491/5166/products/LS_9020_56b70f56-f530-40ec-8ffe-960c10771d07_grande.jpg?v=1594243084',
          'http://cdn.shopify.com/s/files/1/1491/5166/products/LS_9036_8e7fa6bb-85ec-4149-af19-091df2e4f92d_grande.jpg?v=1594243084',
          'https://cdn.shopify.com/s/files/1/1491/5166/products/LS_9036_8e7fa6bb-85ec-4149-af19-091df2e4f92d_grande.jpg?v=1594243084'
        ]
      },
      url: 'https://unboundmerino.com/products/3-pack-merino-all-season-full-length-socks-1',
      merchant: 'Unbound Merino'
    }
  })

  await prisma.product.create({
    data: {
      title: "Women's Slip On | Black",
      images: {
        set: [
          'http://cdn.shopify.com/s/files/1/0026/5302/8425/products/w-s-black_1200x1200.jpg?v=1574244588',
          'http://cdn.shopify.com/s/files/1/0026/5302/8425/products/02._Mens_White_Black_Three_Quarter_View_1200x1200.jpg?v=1574244588',
          'http://cdn.shopify.com/s/files/1/0026/5302/8425/products/03._Womens_White_Black_Back_View-01_1200x1200.jpg?v=1574244588',
          'https://cdn.shopify.com/s/files/1/0026/5302/8425/products/w-s-black_1200x1200.jpg?v=1574244588',
          'https://cdn.shopify.com/s/files/1/0026/5302/8425/products/02._Mens_White_Black_Three_Quarter_View_1200x1200.jpg?v=1574244588',
          'https://cdn.shopify.com/s/files/1/0026/5302/8425/products/03._Womens_White_Black_Back_View-01_1200x1200.jpg?v=1574244588'
        ]
      },
      url: 'https://www.thousandfell.com/collections/slip-on/products/womens-slip-on-sneaker-black',
      merchant: 'Thousand Fell'
    }
  })

  await prisma.product.create({
    data: {
      title: "Men's Lace Up | White",
      images: {
        set: [
          'http://cdn.shopify.com/s/files/1/0026/5302/8425/products/l_white_1200x1200.jpg?v=1574235378',
          'http://cdn.shopify.com/s/files/1/0026/5302/8425/products/02._Mens_White_White_Three_Quarter_View_1200x1200.jpg?v=1574236106',
          'http://cdn.shopify.com/s/files/1/0026/5302/8425/products/03._Mens_White_White_Back_View_1200x1200.jpg?v=1574236106',
          'https://cdn.shopify.com/s/files/1/0026/5302/8425/products/l_white_1200x1200.jpg?v=1574235378',
          'https://cdn.shopify.com/s/files/1/0026/5302/8425/products/02._Mens_White_White_Three_Quarter_View_1200x1200.jpg?v=1574236106',
          'https://cdn.shopify.com/s/files/1/0026/5302/8425/products/03._Mens_White_White_Back_View_1200x1200.jpg?v=1574236106'
        ]
      },
      url: 'https://www.thousandfell.com/collections/lace-up/products/mens-lace-up-sneaker-white',
      merchant: 'Thousand Fell'
    }
  })

  await prisma.product.create({
    data: {
      title: '+turmeric beverages by DIRTY LEMON',
      images: {
        set: [
          'https://images.prismic.io/dirtylemon-2018/96df3a862697e8f3db764345ff3b650b36849c8d_img_0287.jpg?auto=compress,format'
        ]
      },
      url: 'https://dirtylemon.com/drink/turmeric',
      merchant: 'DIRTY LEMON'
    }
  })

  await prisma.product.create({
    data: {
      title: '+ginseng beverages by DIRTY LEMON',
      images: {
        set: [
          'https://images.prismic.io/dirtylemon-2018/d11612abcca746f4af27577bc28ae34c9208877c_photo-aug-28-1-41-30-pm.jpg?auto=compress,format'
        ]
      },
      url: 'https://dirtylemon.com/drink/ginseng',
      merchant: 'DIRTY LEMON'
    }
  })

  await prisma.product.create({
    data: {
      title: 'T.L.C. Happi Scalp™ Scrub',
      images: {
        set: [
          '//cdn.shopify.com/s/files/1/0209/8446/products/Happi_Scalp_Scrub_Standard_01_1024px_72dpi_NEW_medium.jpg?v=1585186810'
        ]
      },
      url: 'https://www.drunkelephant.com/collections/hair-collection/products/t-l-c-happi-scalp-scrub',
      merchant: 'drunkelephant'
    }
  })

  await prisma.product.create({
    data: {
      title: 'Embr Wave Bracelet',
      images: {
        set: [
          'http://cdn.shopify.com/s/files/1/2403/5811/products/rose-gold-3-tiny_grande.png?v=1575515327',
          'https://cdn.shopify.com/s/files/1/2403/5811/products/rose-gold-3-tiny_grande.png?v=1575515327',
          'http://cdn.shopify.com/s/files/1/2403/5811/products/rose-gold-2-tiny_6da8a453-9968-45b5-acb9-ac92bff44033_grande.jpg?v=1575515327',
          'https://cdn.shopify.com/s/files/1/2403/5811/products/rose-gold-2-tiny_6da8a453-9968-45b5-acb9-ac92bff44033_grande.jpg?v=1575515327',
          'http://cdn.shopify.com/s/files/1/2403/5811/products/rose-gold-1_grande.png?v=1575515327',
          'https://cdn.shopify.com/s/files/1/2403/5811/products/rose-gold-1_grande.png?v=1575515327'
        ]
      },
      url: 'https://embrlabs.com/products/embr-wave',
      merchant: 'Embr Labs'
    }
  })

  await prisma.product.create({
    data: {
      title: 'Hatch Valley Green',
      images: {
        set: [
          'http://cdn.shopify.com/s/files/1/0252/5593/6086/products/ScreenShot2020-03-20at7.18.09PM_1200x1200.png?v=1584753837',
          'http://cdn.shopify.com/s/files/1/0252/5593/6086/products/HVGCapture_1200x1200.jpg?v=1584760967',
          'https://cdn.shopify.com/s/files/1/0252/5593/6086/products/ScreenShot2020-03-20at7.18.09PM_1200x1200.png?v=1584753837',
          'https://cdn.shopify.com/s/files/1/0252/5593/6086/products/HVGCapture_1200x1200.jpg?v=1584760967'
        ]
      },
      url: 'https://www.flatironpepper.com/products/hatch-valley-green',
      merchant: 'Flatiron Pepper Co'
    }
  })

  await prisma.product.create({
    data: {
      title: "I Can't Feel My Face",
      images: {
        set: [
          'http://cdn.shopify.com/s/files/1/0252/5593/6086/products/Ican_tfeelmyfacesingle_1200x1200.png?v=1584755353',
          'http://cdn.shopify.com/s/files/1/0252/5593/6086/products/ebox_1200x1200.png?v=1584755353',
          'http://cdn.shopify.com/s/files/1/0252/5593/6086/products/creen_Shot_2019-10-24_at_2.43.31_PM_1200x1200.png?v=1584755353',
          'https://cdn.shopify.com/s/files/1/0252/5593/6086/products/Ican_tfeelmyfacesingle_1200x1200.png?v=1584755353',
          'https://cdn.shopify.com/s/files/1/0252/5593/6086/products/ican_tfeelmyfacebox_1200x1200.png?v=1584755353',
          'https://cdn.shopify.com/s/files/1/0252/5593/6086/products/Screen_Shot_2019-10-24_at_2.43.31_PM_1200x1200.png?v=1584755353'
        ]
      },
      url: 'https://www.flatironpepper.com/products/i-cant-feel-my-face',
      merchant: 'Flatiron Pepper Co'
    }
  })

  await prisma.product.create({
    data: {
      title: 'La Sélection Nomade',
      images: {
        set: [
          'https://media-live.byredo.com/media/catalog/product/optimized/8/5/8529df057ba542031c76db2227539212ccfb359560579b72c48c9f95905e385f/mob_la-selection-nomade-3x12-ml_1_1.jpg'
        ]
      },
      url: 'https://www.byredo.com/us_en/la-selection-nomade-eau-de-parfum-3x12ml',
      merchant: ''
    }
  })

  await prisma.product.create({
    data: {
      title: 'Ultra High Rise Ankle Straight Jeans',
      images: { set: [] },
      url:
        'https://www.abercrombie.com/shop/us/p/ultra-high-rise-ankle-straight-jeans-41996353?categoryId=6234532&seq=01&faceout=prod1',
      merchant: 'Abercrombie & Fitch'
    }
  })

  await prisma.product.create({
    data: {
      title: 'Juan Soto Washington Nationals Nike Youth 2020 Gold Program Replica Player Jersey - White/Gold',
      images: {
        set: [
          'https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3802000/ff_3802240-4b85edcce601a42d6641_full.jpg'
        ]
      },
      url:
        'https://www.fanatics.com/mlb/washington-nationals/juan-soto-washington-nationals-nike-youth-2020-gold-program-replica-player-jersey-white/gold/o-7887+t-58234569+p-8153449092+z-8-1618303961?_ref=p-CLP:m-GRID:i-r4c0:po-12',
      merchant: 'Fanatics'
    }
  })

  prisma.$disconnect()
}

seed().catch((e) => console.error(e))
