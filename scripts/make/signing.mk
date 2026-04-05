KEYDIR := /usr/share/vboot/devkeys
KEYEXT := .vbprivk
PUBKEYEXT := .vbpubk
KEYBLOCKEXT := .keyblock
ifeq ($(RECOVERY),1)
ifneq ($(TARGET),aarch64)
DATA_KEY := $(KEYDIR)/recovery_kernel_data_key$(KEYEXT)
PUB_DATA_KEY := $(KEYDIR)/recovery_kernel_data_key$(PUBKEYEXT)
KEYBLOCK := $(KEYDIR)/recovery_kernel$(KEYBLOCKEXT)
else
DATA_KEY := $(KEYDIR)/kernel_data_key$(KEYEXT)
PUB_DATA_KEY := $(KEYDIR)/kernel_data_key$(PUBKEYEXT)
KEYBLOCK := $(KEYDIR)/kernel$(KEYBLOCKEXT)
RECO_DATA_KEY := $(KEYDIR)/recovery_kernel_data_key$(KEYEXT)
RECO_PUB_DATA_KEY := $(KEYDIR)/recovery_kernel_data_key$(PUBKEYEXT)
RECO_KEYBLOCK := $(KEYDIR)/recovery_kernel$(KEYBLOCKEXT)
endif
endif
ifneq ($(RECOVERY),1)
DATA_KEY := $(KEYDIR)/kernel_data_key$(KEYEXT)
PUB_DATA_KEY := $(KEYDIR)/kernel_data_key$(PUBKEYEXT)
KEYBLOCK := $(KEYDIR)/kernel$(KEYBLOCKEXT) 
endif
