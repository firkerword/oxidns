include $(TOPDIR)/rules.mk

PKG_NAME:=oxidns
PKG_VERSION:=1.6.0
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/svenshi/oxidns/releases/download/v$(PKG_VERSION)
PKG_SOURCE:=oxidns-$(ARCH)-unknown-linux-musl.tar.gz
PKG_HASH:=185d0c2ff627d0bf6154c3c2df618271d224684219a53712c3b763d5317d8c27

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/oxidns
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OxiDNS - Rust DNS engine
  URL:=https://github.com/svenshi/oxidns
  DEPENDS:=+libc
endef

define Package/oxidns/description
  OxiDNS is a high-performance programmable DNS engine written in Rust.
endef

define Build/Prepare
    $(call Build/Prepare/Default)
    mkdir -p $(PKG_BUILD_DIR)
    tar -xzf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR)
endef

define Build/Compile
    # No compile step, using prebuilt binary
    true
endef

define Package/oxidns/install
    $(INSTALL_DIR) $(1)/usr/bin
    $(INSTALL_BIN) $(PKG_BUILD_DIR)/oxidns $(1)/usr/bin/

    $(INSTALL_DIR) $(1)/usr/share/oxidns/webui
    $(CP) $(PKG_BUILD_DIR)/webui/* $(1)/usr/share/oxidns/webui/

    $(INSTALL_DIR) $(1)/etc/oxidns
    $(INSTALL_CONF) $(PKG_BUILD_DIR)/config.yaml.example $(1)/etc/oxidns/config.yaml
endef

$(eval $(call BuildPackage,oxidns))
