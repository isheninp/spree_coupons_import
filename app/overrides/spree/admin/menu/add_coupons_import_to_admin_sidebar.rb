Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_promotion',
  name: 'add_coupons_import_admin_sub_menu_tab',
  insert_bottom: '[data-hook="admin_promotion_sub_tabs"]',
  text: '<%= tab :coupons_import_new, label: Spree.t("coupons_import.menu") %>'
)