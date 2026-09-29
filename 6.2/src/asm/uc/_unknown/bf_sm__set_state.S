/* bf_sm__set_state @ 0x92af2c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__on_brp_resp, bf_sm__on_txss_resp, bf_sm__txss_init_result
 * Зовёт сам: __ld_r13_to_r13_ret, bf__clear_sta_bit_state34
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__set_state
bf_sm__set_state:
	.global L_92af2c
L_92af2c:
	push_s blink
L_92af2e:
	sub_s r2,r1,0x3
L_92af30:
	push_s r13
L_92af32:
	brhs.d r2,0x8,L_92af8c
L_92af36:
	mov_s r3,r1
L_92af38:
	ldb.x r2,[0x801818,r2]
L_92af40:
	add r1,pcl,0x8
L_92af44:
	add1_s r1,r1,r2
L_92af46:
	j_s [r1]
L_92af48:
	mov_s r1,0x0
L_92af4a:
	mov_s r2,0x80216c
L_92af50:
	stw_s r1,[r2,0x24]
L_92af52:
	asl_s r1,r0,0x4
L_92af54:
	add2_s r1,r1,r1
L_92af56:
	add_s r1,r1,0x801104
L_92af5c:
	ldw_s r13,[r1,0x30]
L_92af5e:
	mov_s r3,0x3
	.global L_92af60
L_92af60:
	stw_s r13,[r2,0x1c]
L_92af62:
	ldw_s r13,[r1,0x32]
L_92af64:
	ldw_s r1,[r1,0x34]
L_92af66:
	stw_s r13,[r2,0x1e]
L_92af68:
	stw_s r1,[r2,0x20]
L_92af6a:
	b_s L_92af8c
L_92af6c:
	mov_s r3,0x9
L_92af6e:
	asl_s r1,r0,0x4
L_92af70:
	add2_s r1,r1,r1
L_92af72:
	add_s r1,r1,0x801104
L_92af78:
	mov_s r2,0x80216c
L_92af7e:
	ldw_s r13,[r1,0x30]
L_92af80:
	b_s L_92af60
L_92af82:
	mov_s r2,0x0
L_92af84:
	mov_s r1,0x80216c
L_92af8a:
	stw_s r2,[r1,0x24]
	.global L_92af8c
L_92af8c:
	bl.d L_92ed2c
L_92af90:
	mov_s r1,r3
L_92af92:
	b L_9202ac
L_92af96:
	nop_s
