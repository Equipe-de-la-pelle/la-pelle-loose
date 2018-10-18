module Render
  macro collection(items)
    { data: items, page: 1, per_page: items.size, count: items.size }.to_json
  end

  macro entity(item)
    { data: item }.to_json
  end
end
