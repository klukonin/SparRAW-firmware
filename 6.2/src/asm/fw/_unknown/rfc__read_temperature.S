/* rfc__read_temperature @ 0x8d310c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: temp_sense__prepare_no_rf
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_rfc_read_rgf
 * Глобалы (через gp): 0x800450
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__read_temperature
rfc__read_temperature:
	.global L_8d310c
L_8d310c:
	push_s blink
L_8d310e:
	push_s r13
L_8d3110:
	mov_s r13,r0
L_8d3112:
	breq_s r1,0,L_8d3126
L_8d3114:
	mov r0,0x320
L_8d3118:
	mov lp_count,r0
L_8d311c:
	nop_s
L_8d311e:
	lp L_8d3126
L_8d3122:
	nop_s
L_8d3124:
	nop_s
	.global L_8d3126
L_8d3126:
	mov_s r0,r13
L_8d3128:
	bl.d L_8d3588
L_8d312c:
	mov r1,0x458
L_8d3130:
	mov_s r2,0x7530
L_8d3136:
	mov_s r1,r0
L_8d3138:
	breq r0,0xdeadbeef,L_8d315a
L_8d3140:
	ld_s r0,[gp,0x2cc]
L_8d3142:
	mulu64 r0,r1
L_8d3146:
	mov_s r0,0x8019ec
L_8d314c:
	ld.as r0,[r0,r13]
L_8d3150:
	lsr r1,mlo,0x5
L_8d3154:
	sub_s r1,r1,r2
L_8d3156:
	add_s r0,r0,r1
L_8d3158:
	b_s L_8d315e
	.global L_8d315a
L_8d315a:
	mov r0,-0x1
	.global L_8d315e
L_8d315e:
	b L_8c025c
L_8d3162:
	nop_s
