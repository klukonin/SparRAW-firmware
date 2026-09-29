/* channels_switch_sm__init @ 0x8ed244, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: scan_mngr__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__setup
 * Глобалы (через gp): 0x8001c8
 */
	.section .text.channels_switch_sm__init,"ax",@progbits
	.global channels_switch_sm__init
channels_switch_sm__init:
	.global L_8ed244
L_8ed244:
	push_s blink
L_8ed246:
	bl.d L_8c02bc
L_8ed24a:
	mov r6,0x8
L_8ed24e:
	mov_s r14,r0
L_8ed250:
	mov_s r15,r1
L_8ed252:
	mov_s r16,r2
L_8ed254:
	mov r4,0x8013f8
L_8ed25c:
	mov r5,0x801418
L_8ed264:
	ld.as r1,[gp,0x16]
L_8ed268:
	mov_s r13,0x0
L_8ed26a:
	mov_s r2,r13
L_8ed26c:
	mov_s r3,0x802944
L_8ed272:
	bl.d L_8d6478
L_8ed276:
	mov r7,0x7
L_8ed27a:
	st_s r15,[r14,0x2c]
L_8ed27c:
	st_s r13,[r14,0x40]
L_8ed27e:
	st r16,[r14, 0x44]
L_8ed282:
	st_s r13,[r14,0x34]
L_8ed284:
	st_s r13,[r14,0x3c]
L_8ed286:
	mov_s r0,0x1
L_8ed288:
	b.d L_8c0324
L_8ed28c:
	st_s r0,[r14,0x28]
L_8ed28e:
	nop_s
