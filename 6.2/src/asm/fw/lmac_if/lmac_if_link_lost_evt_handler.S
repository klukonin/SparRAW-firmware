/* lmac_if_link_lost_evt_handler @ 0x8db960, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_link_lost_evt_handler:: High FA while CID %d is connected, clean potential pending FW BF TRIGGER
 *   lmac_if_link_lost_evt_handler:: High FA while disconnected - no need to clean pending FW BF TRIGGER
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit1, l2_mgr__lmac_high_false_alarm_evt_handler, lmac_if__abft_notify_evt, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_link_lost_evt_handler
lmac_if_link_lost_evt_handler:
	.global L_8db960
L_8db960:
	push_s blink
L_8db962:
	push_s r13
L_8db964:
	mov_s r13,r0
L_8db966:
	mov_s r0,0x803c00
L_8db96c:
	ld_s r0,[r0,0x20]
L_8db96e:
	sub_s sp,sp,0x44
L_8db970:
	bbit1 r0,0x1,L_8db9b8
L_8db974:
	ld_s r0,[r13,0x8]
L_8db976:
	brne r0,0x1,L_8db9b8
L_8db97a:
	ld_s r2,[r13]
L_8db97c:
	breq r2,0x8,L_8db9a8
L_8db980:
	mov_s r1,0x1003fdc
L_8db986:
	bl.d L_8dcc10
L_8db98a:
	mov_s r0,0x20
L_8db98c:
	mov_s r0,sp
L_8db98e:
	bl.d L_8c1cd8
L_8db992:
	mov_s r1,0x44
L_8db994:
	mov_s r0,0x0
L_8db996:
	st_s r0,[sp,0x2c]
L_8db998:
	ld_s r0,[r13]
L_8db99a:
	stb_s r0,[sp,0x4]
L_8db99c:
	mov_s r0,0x10
L_8db99e:
	st_s r0,[sp,0x3c]
L_8db9a0:
	bl.d L_8db330
L_8db9a4:
	mov_s r0,sp
L_8db9a6:
	b_s L_8db9b4
	.global L_8db9a8
L_8db9a8:
	mov_s r1,0x1004048
L_8db9ae:
	bl.d L_8dcba8
L_8db9b2:
	mov_s r0,0x20
	.global L_8db9b4
L_8db9b4:
	bl L_8f5f90
	.global L_8db9b8
L_8db9b8:
	b.d L_8c025c
L_8db9bc:
	add_s sp,sp,0x44
L_8db9be:
	nop_s
