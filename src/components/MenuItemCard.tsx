import React, { useState } from 'react';
import { Plus, Minus, ShoppingCart, Package } from 'lucide-react';
import type { Product, ProductVariation } from '../types';

interface MenuItemCardProps {
  product: Product;
  onAddToCart: (product: Product, variation?: ProductVariation, quantity?: number) => void;
  cartQuantity?: number;
  onUpdateQuantity?: (index: number, quantity: number) => void;
  onProductClick?: (product: Product) => void;
}

const MenuItemCard: React.FC<MenuItemCardProps> = ({
  product,
  onAddToCart,
  cartQuantity = 0,
  onProductClick,
}) => {
  const [selectedVariation, setSelectedVariation] = useState<ProductVariation | undefined>(
    product.variations && product.variations.length > 0 ? product.variations[0] : undefined
  );
  const [quantity, setQuantity] = useState(1);

  // Calculate current price considering both product and variation discounts
  const currentPrice = selectedVariation
    ? (selectedVariation.discount_active && selectedVariation.discount_price)
      ? selectedVariation.discount_price
      : selectedVariation.price
    : (product.discount_active && product.discount_price)
      ? product.discount_price
      : product.base_price;

  // Check if there's an active discount
  const hasDiscount = selectedVariation
    ? (selectedVariation.discount_active && selectedVariation.discount_price !== null)
    : (product.discount_active && product.discount_price !== null);

  // Get original price for strikethrough
  const originalPrice = selectedVariation ? selectedVariation.price : product.base_price;

  const handleAddToCart = () => {
    onAddToCart(product, selectedVariation, quantity);
    setQuantity(1);
  };

  const availableStock = selectedVariation ? selectedVariation.stock_quantity : product.stock_quantity;

  // Check if product has any available stock (either in variations or product itself)
  const hasAnyStock = product.variations && product.variations.length > 0
    ? product.variations.some(v => v.stock_quantity > 0)
    : product.stock_quantity > 0;

  const incrementQuantity = () => {
    setQuantity(prev => {
      if (prev >= availableStock) {
        alert(`Only ${availableStock} item(s) available in stock.`);
        return prev;
      }
      return prev + 1;
    });
  };

  const decrementQuantity = () => setQuantity(prev => prev > 1 ? prev - 1 : 1);

  return (
    <div className="bg-[#0a0a0a] h-full flex flex-col group relative border border-white/10 rounded-2xl overflow-hidden hover:border-white/25 transition-all duration-300 hover:shadow-glow">
      {/* Click overlay for product details */}
      <div
        onClick={() => onProductClick?.(product)}
        className="absolute inset-x-0 top-0 h-32 sm:h-52 z-10 cursor-pointer"
        title="View details"
      />

      {/* Product Image */}
      <div className="relative h-32 sm:h-52 bg-[#0d0d0d] overflow-hidden">
        {product.image_url ? (
          <img
            src={product.image_url}
            alt={product.name}
            className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
          />
        ) : (
          <div className="w-full h-full flex items-center justify-center text-gray-600 bg-gradient-to-br from-[#0d0d0d] to-[#1a1a1a]">
            <Package className="w-16 h-16" />
          </div>
        )}

        {/* Gradient overlay */}
        <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent" />

        {/* Badges */}
        <div className="absolute top-3 left-3 flex flex-col gap-2 pointer-events-none">
          {product.featured && (
            <span className="px-3 py-1 bg-white text-black text-xs font-bold uppercase tracking-wide rounded-full">
              Featured
            </span>
          )}
          {hasDiscount && (
            <span className="px-3 py-1 bg-white/10 backdrop-blur-sm text-white text-xs font-bold rounded-full border border-white/20">
              {Math.round((1 - currentPrice / originalPrice) * 100)}% OFF
            </span>
          )}
        </div>

        {/* Stock Status Overlay */}
        {(!product.available || !hasAnyStock) && (
          <div className="absolute inset-0 bg-black/70 backdrop-blur-sm flex items-center justify-center">
            <span className="bg-white/10 backdrop-blur-sm text-white px-4 py-2 text-sm font-bold rounded-full border border-white/20">
              {!product.available ? 'Unavailable' : 'Out of Stock'}
            </span>
          </div>
        )}
      </div>

      {/* Product Details */}
      <div className="p-3 sm:p-5 flex-1 flex flex-col">
        <h3 className="font-bold text-white text-sm sm:text-lg mb-1 sm:mb-2 line-clamp-2 tracking-tight">{product.name}</h3>
        <p className="text-xs text-gray-500 mb-2 sm:mb-4 line-clamp-2 min-h-[2rem] sm:min-h-[2.5rem] leading-tight">{product.description}</p>

        {/* Variations (Sizes) */}
        <div className="mb-2 sm:mb-4 min-h-[2rem] sm:min-h-[2.5rem]">
          {product.variations && product.variations.length > 0 && (
            <div className="flex flex-wrap gap-1.5 sm:gap-2">
              {product.variations.slice(0, 3).map((variation) => {
                const isOutOfStock = variation.stock_quantity === 0;
                return (
                  <button
                    key={variation.id}
                    onClick={(e) => {
                      e.stopPropagation();
                      if (!isOutOfStock) {
                        setSelectedVariation(variation);
                      }
                    }}
                    disabled={isOutOfStock}
                    className={`
                      px-2 sm:px-3 py-1 sm:py-1.5 text-[10px] sm:text-xs font-medium rounded-md sm:rounded-lg transition-all duration-200 relative z-20
                      ${selectedVariation?.id === variation.id && !isOutOfStock
                        ? 'bg-white text-black'
                        : isOutOfStock
                          ? 'bg-white/5 text-gray-600 cursor-not-allowed'
                          : 'bg-white/10 text-gray-300 hover:bg-white/20 border border-white/10'
                      }
                    `}
                  >
                    {variation.name}
                  </button>
                );
              })}
              {product.variations.length > 3 && (
                <span className="text-xs text-gray-500 self-center">
                  +{product.variations.length - 3}
                </span>
              )}
            </div>
          )}
        </div>

        <div className="flex-1" />

        {/* Price and Cart Actions */}
        <div className="flex flex-col gap-3 sm:gap-4 mt-auto">
          {hasDiscount ? (
            <div className="flex items-baseline gap-2 sm:gap-3">
              <span className="text-lg sm:text-2xl font-black text-white">
                ₱{currentPrice.toLocaleString('en-PH', { minimumFractionDigits: 0 })}
              </span>
              <span className="text-xs sm:text-sm text-gray-500 line-through">
                ₱{originalPrice.toLocaleString('en-PH', { minimumFractionDigits: 0 })}
              </span>
            </div>
          ) : (
            <div className="flex items-baseline">
              <span className="text-lg sm:text-2xl font-black text-white">
                ₱{currentPrice.toLocaleString('en-PH', { minimumFractionDigits: 0 })}
              </span>
            </div>
          )}

          <div className="flex items-center gap-2 relative z-20">
            {/* Quantity Controls */}
            <div className="flex items-center bg-white/5 border border-white/10 rounded-md sm:rounded-lg">
              <button
                onClick={(e) => {
                  e.stopPropagation();
                  decrementQuantity();
                }}
                className="p-1.5 sm:p-2 hover:bg-white/10 transition-colors rounded-l-lg"
                disabled={!hasAnyStock || !product.available}
              >
                <Minus className="w-3 h-3 sm:w-4 sm:h-4 text-gray-400" />
              </button>
              <span className="w-6 sm:w-10 text-center text-xs sm:text-sm font-bold text-white">
                {quantity}
              </span>
              <button
                onClick={(e) => {
                  e.stopPropagation();
                  incrementQuantity();
                }}
                className="p-1.5 sm:p-2 hover:bg-white/10 transition-colors rounded-r-lg"
                disabled={quantity >= availableStock || !hasAnyStock || !product.available}
              >
                <Plus className="w-3 h-3 sm:w-4 sm:h-4 text-gray-400" />
              </button>
            </div>

            {/* Add to Cart Button */}
            <button
              onClick={(e) => {
                e.stopPropagation();
                if (quantity > availableStock) {
                  alert(`Only ${availableStock} item(s) available in stock.`);
                  setQuantity(availableStock);
                  return;
                }
                handleAddToCart();
              }}
              disabled={!hasAnyStock || availableStock === 0 || !product.available}
              className="flex-1 bg-white text-black px-2 sm:px-4 py-1.5 sm:py-2.5 rounded-md sm:rounded-lg text-xs sm:text-sm font-bold hover:bg-gray-200 transition-all disabled:opacity-30 disabled:cursor-not-allowed flex items-center justify-center gap-1.5 sm:gap-2 shadow-glow hover:shadow-glow-lg"
            >
              <ShoppingCart className="w-3 h-3 sm:w-4 sm:h-4" />
              <span>Add</span>
            </button>
          </div>

          {/* Cart Status */}
          {cartQuantity > 0 && (
            <div className="text-center text-xs text-white/60 font-medium">
              {cartQuantity} in cart
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default MenuItemCard;
