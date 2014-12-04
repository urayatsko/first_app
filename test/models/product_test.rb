require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  fixtures :products

  test "productattributesmustnotbeempty" do
# свойства товара не должны оставаться пустыми
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "productpricemustbepositive" do
    # цена товара должна быть положительной
    product = Product.new(
        title: "My Book Title",
        description: "yyy",
        image_url: "zzz.jpg")

    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join(';')

    # должна быть больше или равна 0.01
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join(';')

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(
        title: "My Book Title",
        description: "yyy",
        image_url: "zzz.jpg",
        price: 1,
        image_url: image_url)
  end

  test "imageurl" do
  # url изображения
    ok = %w{ fred.gif fred.jpg fred.png http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc}
    ok.each do |name|
      assert new_product(name).valid?, "#{name} should n't be invalid"
    # не должно быть неприемлемым
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} should n't be valid"
    # не должно быть приемлемым
    end
  end

end
