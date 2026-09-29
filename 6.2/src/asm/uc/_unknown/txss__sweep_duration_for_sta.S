/* txss__sweep_duration_for_sta @ 0x939cfc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_isr
 * Зовёт сам: txss__sweep_timing
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss__sweep_duration_for_sta
txss__sweep_duration_for_sta:
	.global L_939cfc
L_939cfc:
	push_s blink
L_939cfe:
	mov_s r2,r0
L_939d00:
	mov_s r0,0x801a9c
L_939d06:
	ld_s r1,[r0]
L_939d08:
	ld_s r0,[r0,0x4]
L_939d0a:
	st.a r1,[sp,-0x8]
L_939d0e:
	mul64 r2,0x4c
L_939d12:
	mov_s r1,0x802bb0
L_939d18:
	st_s r0,[sp,0x4]
L_939d1a:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_939d1c:
	ldb r1,[r1,mlo]
L_939d20:
	mov_s r0,sp
L_939d22:
	mov_s r3,0x801150
L_939d28:
	add2_s r2,r2,r2
L_939d2a:
	bl.d L_939cc4
L_939d2e:
	ldb_s r2,[r3,r2]
L_939d30:
	ldw r0,[sp]
L_939d34:
	add_s sp,sp,0x8
L_939d36:
	pop_s blink
L_939d38:
	j_s [blink]
L_939d3a:
	nop_s
