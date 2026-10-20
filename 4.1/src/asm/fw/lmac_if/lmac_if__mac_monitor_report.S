/* lmac_if__mac_monitor_report @ 0x8d865c, 348 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [BTI] | start time 0x%08x%08x | duration %d
 *   [NNL] | tx bcon %d | rx bcon %d | detected %d
 *   [NNL] | rx snr valid %d | rx snr %d
 *   [NNL] | bcon bitmap 0x%08x %08x
 *   [AW ] | start time 0x%08x%08x | duration %d
 *   [NNL] | backoff %d | rx atim %d | bcons_atim_fail_vec 0x%x
 *   [NNL] | tx atim pass %d | tx atim fail %d | tx atim counter %d
 *   [DTI] | start time 0x%08x%08x | duration %d
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_log__emit2, fw_log__emit3, lut__find_index, tail_L2MGR__system_state_evt_handler
 */
	.section .text.lmac_if__mac_monitor_report,"ax",@progbits
	.global lmac_if__mac_monitor_report
lmac_if__mac_monitor_report:
	.global L_8d865c
L_8d865c:
	push_s blink
L_8d865e:
	bl L_8c02c4
L_8d8662:
	mov_s r14,0x854e00
L_8d8668:
	ldb r0,[r14, -0x8]
L_8d866c:
	mov_s r13,0x854d80
L_8d8672:
	breq_s r0,0,L_8d8686
L_8d8674:
	mov_s r0,0x803e30
L_8d867a:
	bl.d L_8c64f4
L_8d867e:
	ld_s r1,[r13,0x7c]
L_8d8680:
	st_s r0,[r14,0x4]
L_8d8682:
	mov_s r0,0x1
L_8d8684:
	stb_s r0,[r14]
	.global L_8d8686
L_8d8686:
	mov_s r0,0x2
L_8d8688:
	ld r4,[r13, 0x6c]
L_8d868c:
	mov_s r2,0x10044f0
L_8d8692:
	ld r5,[r13, 0x74]
L_8d8696:
	mov_s r1,r0
L_8d8698:
	bl.d L_8ee034
L_8d869c:
	ld_s r3,[r13,0x70]
L_8d869e:
	mov_s r0,0x2
L_8d86a0:
	ldb r4,[r14, 0x9]
L_8d86a4:
	mov_s r2,0x1004520
L_8d86aa:
	ldb r5,[r14, 0xa]
L_8d86ae:
	mov_s r1,r0
L_8d86b0:
	bl.d L_8ee034
L_8d86b4:
	ldb_s r3,[r14,0x8]
L_8d86b6:
	mov_s r2,0x1004550
L_8d86bc:
	ld r4,[r14, 0x4]
L_8d86c0:
	mov_s r0,0x2
L_8d86c2:
	mov_s r1,r0
L_8d86c4:
	bl.d L_8edff8
L_8d86c8:
	ldb_s r3,[r14]
L_8d86ca:
	mov_s r2,0x1004574
L_8d86d0:
	ld r4,[r13, 0x64]
L_8d86d4:
	mov_s r0,0x2
L_8d86d6:
	mov_s r1,r0
L_8d86d8:
	bl.d L_8edff8
L_8d86dc:
	ld_s r3,[r13,0x68]
L_8d86de:
	mov_s r0,0x2
L_8d86e0:
	ld r4,[r14, 0xc]
L_8d86e4:
	mov_s r2,0x1004598
L_8d86ea:
	ld r5,[r14, 0x14]
L_8d86ee:
	mov_s r1,r0
L_8d86f0:
	bl.d L_8ee034
L_8d86f4:
	ld_s r3,[r14,0x10]
L_8d86f6:
	mov_s r0,0x2
L_8d86f8:
	ldb r4,[r14, 0x1c]
L_8d86fc:
	mov_s r2,0x10045c8
L_8d8702:
	ldb r5,[r14, 0x1d]
L_8d8706:
	mov_s r1,r0
L_8d8708:
	bl.d L_8ee034
L_8d870c:
	ldb_s r3,[r14,0x18]
L_8d870e:
	mov_s r0,0x2
L_8d8710:
	ldb r4,[r14, 0x1a]
L_8d8714:
	mov_s r2,0x1004604
L_8d871a:
	ldb r5,[r14, 0x1b]
L_8d871e:
	mov_s r1,r0
L_8d8720:
	bl.d L_8ee034
L_8d8724:
	ldb_s r3,[r14,0x19]
L_8d8726:
	mov_s r0,0x2
L_8d8728:
	ld r4,[r14, 0x20]
L_8d872c:
	mov_s r2,0x1004644
L_8d8732:
	ld r5,[r14, 0x28]
L_8d8736:
	mov_s r1,r0
L_8d8738:
	bl.d L_8ee034
L_8d873c:
	ld_s r3,[r14,0x24]
L_8d873e:
	mov_s r0,0x2
L_8d8740:
	ldw r4,[r14, 0x30]
L_8d8744:
	mov_s r2,0x1004674
L_8d874a:
	ldw r5,[r14, 0x3e]
L_8d874e:
	mov_s r1,r0
L_8d8750:
	bl.d L_8ee034
L_8d8754:
	ld_s r3,[r14,0x2c]
L_8d8756:
	mov_s r0,0x2
L_8d8758:
	ldw r4,[r14, 0x34]
L_8d875c:
	mov_s r2,0x10046ac
L_8d8762:
	ldw r5,[r14, 0x36]
L_8d8766:
	mov_s r1,r0
L_8d8768:
	bl.d L_8ee034
L_8d876c:
	ldw_s r3,[r14,0x32]
L_8d876e:
	mov_s r0,0x2
L_8d8770:
	ldw r4,[r14, 0x3a]
L_8d8774:
	mov_s r2,0x10046d8
L_8d877a:
	ldw r5,[r14, 0x3c]
L_8d877e:
	mov_s r1,r0
L_8d8780:
	bl.d L_8ee034
L_8d8784:
	ldw_s r3,[r14,0x38]
L_8d8786:
	mov_s r0,0x2
L_8d8788:
	ldb r4,[r14, 0x41]
L_8d878c:
	mov_s r2,0x1004704
L_8d8792:
	ld r5,[r14, 0x44]
L_8d8796:
	mov_s r1,r0
L_8d8798:
	bl.d L_8ee034
L_8d879c:
	ldb r3,[r14, 0x40]
L_8d87a0:
	mov_s r2,0x100473c
L_8d87a6:
	mov_s r0,0x2
L_8d87a8:
	mov_s r1,r0
L_8d87aa:
	bl.d L_8edfcc
L_8d87ae:
	ld_s r3,[r14,0x4c]
L_8d87b0:
	bl L_8ee760
L_8d87b4:
	b L_8c0334
