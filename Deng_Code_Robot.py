metadata = {
    'protocolName': 'Opentron Protocol for Reaction Mixture Preparation',
    'author': 'Deng the AI Technician',
    'source': 'Custom Request',
    'apiLevel': '2.10'
}

def run(ctx):
    # load labware
    vial_rack = ctx.load_labware('3dprint_8_tuberack_20000ul', '1')
    tube_rack = ctx.load_labware('3dprint_6_tuberack_35000ul', '4')
    tip_rack = ctx.load_labware('opentrons_96_tiprack_300ul', '11')

    # load instrument
    pipette = ctx.load_instrument('p300_single', 'right', tip_racks=[tip_rack])

    # dict to map labware and positions
    vials = {
        'A1': vial_rack.wells_by_name()['A1'],
        'A2': vial_rack.wells_by_name()['A2'],
        'A3': vial_rack.wells_by_name()['A3']
    }

    tubes = {
        'B1': tube_rack.wells_by_name()['B1'],
        'B2': tube_rack.wells_by_name()['B2'],
        'B3': tube_rack.wells_by_name()['B3']
    }

    transfers = [
        ('A1', {'B1': 100, 'B2': 500, 'B3': 800}),
        ('A2', {'B1': 800, 'B2': 100, 'B3': 500}),
        ('A3', {'B1': 200, 'B2': 2000, 'B3': 1500})
    ]

    for vial, tubes_in_transfers in transfers:
        pipette.pick_up_tip()
        for tube, volume in tubes_in_transfers.items():
            pipette.transfer(
                volume,
                vials[vial].bottom(15),
                tubes[tube].top(-2),
                new_tip='never'
            )
        pipette.drop_tip()

    ctx.comment('Protocol complete. Please check the reaction vessels.')
