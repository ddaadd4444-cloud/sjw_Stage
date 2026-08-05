(
    fn findSkinModifier obj =
    (
        for modItem in obj.modifiers do
        (
            if classof modItem == Skin then
            (
                return modItem
            )
        )
        undefined
    )

    if selection.count != 1 then
    (
        messageBox "Select exactly one skinned mesh." title:"Rebuild Skin Mirror"
    )
    else
    (
        local obj = selection[1]
        local skinMod = findSkinModifier obj

        if skinMod == undefined then
        (
            messageBox "No Skin modifier was found." title:"Rebuild Skin Mirror"
        )
        else
        (
            select obj
            max modify mode
            modPanel.setCurrentObject skinMod
            subObjectLevel = 1

            skinMod.mirrorEnabled = false

            -- Use current bone transforms instead of stored initial transforms.
            skinMod.mirrorUseInitialTM = false

            -- Use the more thorough mirror calculation.
            skinMod.mirrorFast = false

            -- Update automatically.
            skinMod.manualUpdate = false

            -- X mirror plane.
            skinMod.mirrorPlane = 0

            skinMod.mirrorEnabled = true
            skinOps.updateMirror skinMod

            completeRedraw()

            format "\n====================================\n"
            format "Skin mirror data rebuilt.\n"
            format "Use Initial TM: %\n" skinMod.mirrorUseInitialTM
            format "Fast Mirror: %\n" skinMod.mirrorFast
            format "Manual Update: %\n" skinMod.manualUpdate
            format "Mirror Threshold: %\n" skinMod.mirrorThreshold
            format "====================================\n"

            messageBox "Mirror data was rebuilt using current bone transforms." title:"Rebuild Complete"
        )
    )
)