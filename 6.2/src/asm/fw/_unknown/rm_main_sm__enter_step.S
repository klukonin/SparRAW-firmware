/* rm_main_sm__enter_step @ 0x8c6954, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__enter_primary_non_locked, sm_pring__timeout, sta_psc_sm__action_8c318c
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_dma__reset_ring, mac_ring_disable, rm_main_sm__check_field_2c, rm_main_sm__count_and_sync_dma_wptr, rm_main_sm__latch_ring_fields, vring__active_ring_table
 * Глобалы (через gp): 0x800188, 0x80018c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__enter_step
rm_main_sm__enter_step:
	.global L_8c6954
L_8c6954:
	push_s blink
L_8c6956:
	push_s r13
L_8c6958:
	bl.d L_8ebff8
L_8c695c:
	mov_s r13,r0
L_8c695e:
	bl.d L_8ea418
L_8c6962:
	ldw_s r0,[r13,0x2]
L_8c6964:
	bl.d L_8d06ec
L_8c6968:
	ldw_s r0,[r13]
L_8c696a:
	mov_s r0,0x18
L_8c696c:
	stw_s r0,[r13,0x2]
L_8c696e:
	mov_s r0,0x0
L_8c6970:
	st_s r0,[r13,0xc]
L_8c6972:
	bl.d L_8c5b08
L_8c6976:
	mov_s r0,r13
L_8c6978:
	mov_s r0,0x1
L_8c697a:
	bl.d L_8d9b44
L_8c697e:
	st_s r0,[r13,0x18]
L_8c6980:
	bl L_8cd080
L_8c6984:
	ld.as r2,[gp,0x1]
L_8c6988:
	ldw_s r0,[r13]
L_8c698a:
	jl_s.d [r2]
L_8c698c:
	ld.as r1,[gp,0x2]
L_8c6990:
	b L_8c025c
