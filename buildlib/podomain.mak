# -*- make -*-

# This creates the file listing used by xgettext and friends based on the
# declared domain of the make file. It also arranges to set the DOMAIN 
# CPPFLAG for the compilation.

MY_DOMAIN := $(PACKAGE)
ifdef DOMAIN
$($(LOCAL)-OBJS): CPPFLAGS := $(CPPFLAGS) -DDOMAIN='"$(DOMAIN)"'
MY_DOMAIN := $(DOMAIN)
endif

MKDIRS += $(PO_DOMAINS)/$(MY_DOMAIN)
$(PO_DOMAINS)/$(MY_DOMAIN)/$(LOCAL).$(TYPE)list: SRC := $(addprefix $(SUBDIR)/,$(SOURCE))
$(PO_DOMAINS)/$(MY_DOMAIN)/$(LOCAL).$(TYPE)list: makefile
	(echo $(SRC) | xargs -n1 echo) > $@
all: $(PO_DOMAINS)/$(MY_DOMAIN)/$(LOCAL).$(TYPE)list

veryclean: veryclean/$(LOCAL)
veryclean/po/$(LOCAL): LIST := $(PO_DOMAINS)/$(MY_DOMAIN)/$(LOCAL).$(TYPE)list
veryclean/po/$(LOCAL):
	rm -f $(LIST)
