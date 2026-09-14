local ITEM_ICON_PATH = "Interface\\AddOns\\EasyGlyph\\Media\\ItemIcons\\"
local itemTexturesByID = EasyGlyphData and EasyGlyphData.itemTexturesByID or {}
local itemTexturesByName = EasyGlyphData and EasyGlyphData.itemTexturesByName or {}
local hooked = {}
local bagnonHooked = false

local function GetItemID(value)
    if type(value) == "number" then
        return value
    end

    if type(value) ~= "string" then
        return nil
    end

    local itemID = string.match(value, "item:(%d+)")
    if itemID then
        return tonumber(itemID)
    end

    return tonumber(value)
end

local function GetItemTextureStem(value)
    local itemID = GetItemID(value)
    if itemID and itemTexturesByID[itemID] then
        return itemTexturesByID[itemID]
    end

    if type(value) ~= "string" then
        return nil
    end

    local name = value
    if string.find(value, "|Hitem:") and type(GetItemInfo) == "function" then
        name = GetItemInfo(value) or value
    end

    return itemTexturesByName[name]
end

local function GetButtonTexture(button)
    if not button then
        return nil
    end

    if button.icon and type(button.icon.SetTexture) == "function" then
        return button.icon
    end

    if button.Icon and type(button.Icon.SetTexture) == "function" then
        return button.Icon
    end

    if type(button.GetName) == "function" then
        local name = button:GetName()
        if name then
            local texture = _G[name .. "IconTexture"] or _G[name .. "Icon"]
            if texture and type(texture.SetTexture) == "function" then
                return texture
            end
        end
    end

    if type(button.GetNormalTexture) == "function" then
        local texture = button:GetNormalTexture()
        if texture and type(texture.SetTexture) == "function" then
            return texture
        end
    end

    return nil
end

local function SetReplacementTexture(texture, stem)
    if not texture or not stem or type(texture.SetTexture) ~= "function" then
        return false
    end

    texture:SetTexture(ITEM_ICON_PATH .. stem)

    if type(texture.SetTexCoord) == "function" then
        texture:SetTexCoord(0, 1, 0, 1)
    end

    return true
end

local function ApplyTexture(texture, value)
    return SetReplacementTexture(texture, GetItemTextureStem(value))
end

local function ApplyButton(button, value)
    if not button then
        return false
    end

    local stem = GetItemTextureStem(value)
    if not stem then
        return false
    end

    local texture = GetButtonTexture(button)
    if texture then
        return SetReplacementTexture(texture, stem)
    end

    if type(button.SetNormalTexture) == "function" then
        button:SetNormalTexture(ITEM_ICON_PATH .. stem)
        return true
    end

    return false
end

local function Hook(name, callback)
    if hooked[name] or type(hooksecurefunc) ~= "function" or type(_G[name]) ~= "function" then
        return
    end

    hooksecurefunc(name, callback)
    hooked[name] = true
end

local function UpdateContainerItemButton(button)
    if not button or type(button.GetID) ~= "function" or type(button.GetParent) ~= "function" then
        return
    end

    local parent = button:GetParent()
    if not parent or type(parent.GetID) ~= "function" then
        return
    end

    local bagID = parent:GetID()
    local slotID = button:GetID()
    if type(bagID) ~= "number" or type(slotID) ~= "number" then
        return
    end

    ApplyButton(button, GetContainerItemLink(bagID, slotID))
end

local function UpdateBagnonItemButton(button)
    if not button then
        return
    end

    local link
    if type(button.GetItem) == "function" then
        link = button:GetItem()
    end

    if not link and type(button.GetBag) == "function" and type(button.GetID) == "function" then
        local bagID = button:GetBag()
        local slotID = button:GetID()
        if type(bagID) == "number" and type(slotID) == "number" and type(GetContainerItemLink) == "function" then
            link = GetContainerItemLink(bagID, slotID)
        end
    end

    ApplyButton(button, link)
end

local function InstallBagnonHook()
    -- bagnon repaints its own slots, hook it after that
    if bagnonHooked or type(hooksecurefunc) ~= "function" then
        return
    end

    if Bagnon and Bagnon.ItemSlot and type(Bagnon.ItemSlot.Update) == "function" then
        hooksecurefunc(Bagnon.ItemSlot, "Update", UpdateBagnonItemButton)
        bagnonHooked = true
    end
end

local function UpdateContainer(frame)
    if not frame or type(frame.GetID) ~= "function" or type(frame.GetName) ~= "function" then
        return
    end

    local bagID = frame:GetID()
    local frameName = frame:GetName()
    local size = frame.size or 0

    for i = 1, size do
        local button = _G[frameName .. "Item" .. i]
        if button and type(button.GetID) == "function" then
            local link = GetContainerItemLink(bagID, button:GetID())
            ApplyButton(button, link)
        end
    end
end

local function UpdateBankButton(button)
    if not button or button.isBag or type(button.GetID) ~= "function" then
        return
    end

    ApplyButton(button, GetContainerItemLink(BANK_CONTAINER, button:GetID()))
end

local function UpdateMerchantItems()
    local perPage = MERCHANT_ITEMS_PER_PAGE or 10
    local page = MerchantFrame and MerchantFrame.page or 1

    for i = 1, perPage do
        local index = ((page - 1) * perPage) + i
        local button = _G["MerchantItem" .. i .. "ItemButton"]
        ApplyButton(button, type(GetMerchantItemLink) == "function" and GetMerchantItemLink(index))
    end

    if MerchantBuyBackItemItemButton and type(GetNumBuybackItems) == "function" then
        ApplyButton(MerchantBuyBackItemItemButton, GetBuybackItemLink(GetNumBuybackItems()))
    end
end

local function UpdateBuybackItems()
    local perPage = BUYBACK_ITEMS_PER_PAGE or 12

    for i = 1, perPage do
        local button = _G["MerchantItem" .. i .. "ItemButton"]
        if button and type(button.GetID) == "function" then
            ApplyButton(button, GetBuybackItemLink(button:GetID()))
        end
    end
end

local function UpdateTradeSkillIcon(skillID)
    skillID = skillID or (type(GetTradeSkillSelectionIndex) == "function" and GetTradeSkillSelectionIndex())
    if not skillID or skillID <= 0 or not TradeSkillSkillIcon then
        return
    end

    local link = type(GetTradeSkillItemLink) == "function" and GetTradeSkillItemLink(skillID)
    if not link and type(GetTradeSkillInfo) == "function" then
        link = GetTradeSkillInfo(skillID)
    end

    ApplyButton(TradeSkillSkillIcon, link)
end

local function UpdateAuctionRows(kind, prefix, scrollFrame, count)
    if type(GetAuctionItemLink) ~= "function" or not scrollFrame then
        return
    end

    local offset = type(FauxScrollFrame_GetOffset) == "function" and FauxScrollFrame_GetOffset(scrollFrame) or 0
    for i = 1, count do
        local link = GetAuctionItemLink(kind, offset + i)
        ApplyTexture(_G[prefix .. i .. "ItemIconTexture"], link)
    end
end

local function UpdateAuctionBrowse()
    UpdateAuctionRows("list", "BrowseButton", BrowseScrollFrame, NUM_BROWSE_TO_DISPLAY or 8)
end

local function UpdateAuctionBids()
    UpdateAuctionRows("bidder", "BidButton", BidScrollFrame, NUM_BIDS_TO_DISPLAY or 9)
end

local function UpdateAuctionOwner()
    UpdateAuctionRows("owner", "AuctionsButton", AuctionsScrollFrame, NUM_AUCTIONS_TO_DISPLAY or 9)
end

local function UpdateAuctionSellItem()
    if not AuctionsItemButton or type(GetAuctionSellItemInfo) ~= "function" then
        return
    end

    local name = GetAuctionSellItemInfo()
    ApplyButton(AuctionsItemButton, name)
end

local function UpdateOpenMail()
    if not InboxFrame or not InboxFrame.openMailID or type(GetInboxItemLink) ~= "function" then
        return
    end

    local maxAttachments = ATTACHMENTS_MAX_RECEIVE or 16
    for i = 1, maxAttachments do
        ApplyButton(_G["OpenMailAttachmentButton" .. i], GetInboxItemLink(InboxFrame.openMailID, i))
    end
end

local function UpdateSendMail()
    local maxAttachments = ATTACHMENTS_MAX_SEND or 12
    for i = 1, maxAttachments do
        local value
        if type(GetSendMailItemLink) == "function" then
            value = GetSendMailItemLink(i)
        end
        if not value and type(GetSendMailItem) == "function" then
            value = GetSendMailItem(i)
        end
        ApplyButton(_G["SendMailAttachment" .. i], value)
    end
end

local function UpdateTradePlayerItem(id)
    if not id or id == TRADE_ENCHANT_SLOT then
        return
    end

    local value = type(GetTradePlayerItemLink) == "function" and GetTradePlayerItemLink(id)
    if not value and type(GetTradePlayerItemInfo) == "function" then
        value = GetTradePlayerItemInfo(id)
    end

    ApplyButton(_G["TradePlayerItem" .. id .. "ItemButton"], value)
end

local function UpdateTradeTargetItem(id)
    if not id or id == TRADE_ENCHANT_SLOT then
        return
    end

    local value = type(GetTradeTargetItemLink) == "function" and GetTradeTargetItemLink(id)
    if not value and type(GetTradeTargetItemInfo) == "function" then
        value = GetTradeTargetItemInfo(id)
    end

    ApplyButton(_G["TradeRecipientItem" .. id .. "ItemButton"], value)
end

local function UpdateLootButton(index)
    local button = _G["LootButton" .. index]
    if not button then
        return
    end

    local slot = button.slot
    if slot and type(GetLootSlotLink) == "function" then
        ApplyTexture(_G["LootButton" .. index .. "IconTexture"], GetLootSlotLink(slot))
    end
end

local function UpdateGuildBank()
    if not GuildBankFrame or GuildBankFrame.mode ~= "bank" or type(GetCurrentGuildBankTab) ~= "function" then
        return
    end

    local tab = GetCurrentGuildBankTab()
    local maxSlots = MAX_GUILDBANK_SLOTS_PER_TAB or 98
    local perColumn = NUM_SLOTS_PER_GUILDBANK_GROUP or 14

    for slot = 1, maxSlots do
        local index = mod(slot, perColumn)
        if index == 0 then
            index = perColumn
        end

        local column = math.ceil((slot - 0.5) / perColumn)
        local button = _G["GuildBankColumn" .. column .. "Button" .. index]
        local link = type(GetGuildBankItemLink) == "function" and GetGuildBankItemLink(tab, slot)
        ApplyButton(button, link)
    end
end

local function RefreshVisibleFrames()
    for i = 1, NUM_CONTAINER_FRAMES or 0 do
        local frame = _G["ContainerFrame" .. i]
        if frame and frame:IsShown() then
            UpdateContainer(frame)
        end
    end

    if MerchantFrame and MerchantFrame:IsShown() then
        if MerchantFrame.selectedTab == 1 then
            UpdateMerchantItems()
        else
            UpdateBuybackItems()
        end
    end

    if TradeSkillFrame and TradeSkillFrame:IsShown() then
        UpdateTradeSkillIcon()
    end

    if AuctionFrame and AuctionFrame:IsShown() then
        UpdateAuctionBrowse()
        UpdateAuctionBids()
        UpdateAuctionOwner()
        UpdateAuctionSellItem()
    end

    if OpenMailFrame and OpenMailFrame:IsShown() then
        UpdateOpenMail()
    end

    if SendMailFrame and SendMailFrame:IsShown() then
        UpdateSendMail()
    end

    if GuildBankFrame and GuildBankFrame:IsShown() then
        UpdateGuildBank()
    end
end

local function InstallHooks()
    Hook("ContainerFrameItemButton_Update", UpdateContainerItemButton)
    Hook("ContainerFrame_Update", UpdateContainer)
    Hook("BankFrameItemButton_Update", UpdateBankButton)
    Hook("MerchantFrame_UpdateMerchantInfo", UpdateMerchantItems)
    Hook("MerchantFrame_UpdateBuybackInfo", UpdateBuybackItems)
    Hook("TradeSkillFrame_SetSelection", UpdateTradeSkillIcon)
    Hook("TradeSkillFrame_Update", UpdateTradeSkillIcon)
    Hook("AuctionFrameBrowse_Update", UpdateAuctionBrowse)
    Hook("AuctionFrameBid_Update", UpdateAuctionBids)
    Hook("AuctionFrameAuctions_Update", UpdateAuctionOwner)
    Hook("AuctionSellItemButton_OnEvent", UpdateAuctionSellItem)
    Hook("OpenMail_Update", UpdateOpenMail)
    Hook("SendMailFrame_Update", UpdateSendMail)
    Hook("TradeFrame_UpdatePlayerItem", UpdateTradePlayerItem)
    Hook("TradeFrame_UpdateTargetItem", UpdateTradeTargetItem)
    Hook("LootFrame_UpdateButton", UpdateLootButton)
    Hook("GuildBankFrame_Update", UpdateGuildBank)

    InstallBagnonHook()
    RefreshVisibleFrames()
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:RegisterEvent("PLAYER_LOGIN")
loader:RegisterEvent("BAG_UPDATE")
loader:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
loader:RegisterEvent("PLAYERBANKBAGSLOTS_UPDATED")
loader:RegisterEvent("MERCHANT_UPDATE")
loader:RegisterEvent("MAIL_INBOX_UPDATE")
loader:RegisterEvent("TRADE_SKILL_UPDATE")
loader:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
loader:RegisterEvent("AUCTION_OWNED_LIST_UPDATE")
loader:RegisterEvent("AUCTION_BIDDER_LIST_UPDATE")
loader:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED")

loader:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" or event == "PLAYER_LOGIN" then
        InstallHooks()
        return
    end

    InstallBagnonHook()
    RefreshVisibleFrames()
end)

InstallHooks()
