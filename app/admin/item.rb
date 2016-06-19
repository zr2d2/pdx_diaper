# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  category   :string
#  created_at :datetime
#  updated_at :datetime
#
# (modified 18 June 2016)


ActiveAdmin.register Item do

  menu parent: "Inventory", label: "Item types"

  permit_params :name, :category, :size

  filter :inventories, label: "Stored In"
  filter :name
  filter :category, as: :select
  filter :created_at

  index do 
    selectable_column
    column :name
    column :category
    column "Barcode Entries" do |i|
      entries = BarcodeItem.where(item_id: i).count
      link_to_unless(entries == 0, entries, barcode_items_path(utf8:"✓", "q[item_id_eq]": i, item_id_eq: i, commit: "Filter", order: "id_desc")) 
    end
    actions
  end
end