[
  {
    ended_at: '22.05.17',
    name: "Alya Red Gray Striped Cotton Jersey Dress Long Sleeves Women's Size S Small NWT",
    ebay_url: "http://i.ebayimg.com/00/s/NzgzWDUwMA==/z/yxEAAOSw44BYCYBI/$_1.JPG?set_id=880000500F;"
  },
  {
    ended_at: '22.05.17',
    name: "Alya Red Gray Striped Cotton Jersey Dress Long Sleeves Women's Size S Small NWT",
    ebay_url: "http://i.ebayimg.com/00/s/MTU5M1gxMTcy/z/pZYAAOSw9GhYdbZW/$_12.JPG?set_id=880000500F;"
  },
  {
    ended_at: '22.05.17',
    name: "Alya Red Gray Striped Cotton Jersey Dress Long Sleeves Women's Size S Small NWT",
    ebay_url: "http://i.ebayimg.com/00/s/MTYwMFgxNjAw/z/UBIAAOSwzgBY0-k6/$_12.JPG?set_id=880000500F"
  },
  {
    ended_at: '15.05.17',
    name: "Alya Red Gray Striped Cotton Jersey Dress Long Sleeves Women's Size S Small NWT",
    ebay_url: "http://i.ebayimg.com/00/s/MTYwMFgxMjAw/z/JuYAAOSwTM5Yy4VA/$_1.JPG?set_id=880000500F"
  },
  {
    ended_at: '06.05.17',
    name: "NWT BCBG MAX AZRIA $498 NAVY Pageant Homecoming Gown 12",
    ebay_url: "http://i.ebayimg.com/00/s/ODAwWDUyMw==/z/uSkAAMXQjWtRLsrf/$T2eC16dHJF8E9nnC8H5iBRLsrelOw!~~60_1.JPG?set_id=880000500F"
  },
  {
    ended_at: "23.05.17",
    name: "London Times Women's Size 6 Black Cap Sleeve Collar Neck Dress",
    ebay_url: "http://i.ebayimg.com/00/s/NjAwWDYwMA==/z/opMAAOxyq5NRC-dh/$(KGrHqVHJFQFDy)2F!scBRC-dhwhVg~~60_1.JPG?set_id=880000500F"
  },
  {
    ended_at: "05.05.17",
    name: "Boston Proper Seasonless Belted Sheath Dress Women's Rose Gold Size 4 NWT 129.00",
    ebay_url: "http://i.ebayimg.com/00/s/OTk5WDc0OQ==/z/28YAAOSwU-pXqRRu/$_12.JPG?set_id=880000500F"
  }
].each do |item|
  # URI(item[:ebay_url])
  # binding.pry
  Frame.where(name: item[:name]).first_or_create!(
    ended_at: item[:ended_at].to_date,
    ebay_url: item[:ebay_url],
    remote_photo_url: item[:ebay_url]
  )
end
