/* mlme_sm__init @ 0x8ed454, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: connection__init
 * Зовёт сам: basic_sm__setup
 * Глобалы (через gp): 0x8001b0, 0x8001d8
 */
	.section .text.mlme_sm__init,"ax",@progbits
	.global mlme_sm__init
mlme_sm__init:
	.global L_8ed454
L_8ed454:
	mov_s r2,0x0
L_8ed456:
	st_s r2,[r0,0x30]
L_8ed458:
	st_s r2,[r0,0x2c]
L_8ed45a:
	st_s r2,[r0,0x34]
L_8ed45c:
	st_s r2,[r0,0x38]
L_8ed45e:
	mov_s r3,0x1
L_8ed460:
	st_s r1,[r0,0x3c]
L_8ed462:
	ld.as r1,[gp,0x1a]
L_8ed466:
	stw r3,[r0, 0x46]
L_8ed46a:
	stw r2,[r0, 0x44]
L_8ed46e:
	st_s r2,[r0,0x48]
L_8ed470:
	brne_s r1,0,L_8ed476
L_8ed472:
	st.as r3,[gp,0x1a]
	.global L_8ed476
L_8ed476:
	mov r4,0x801020
L_8ed47e:
	mov r5,0x801044
L_8ed486:
	ld.as r1,[gp,0x10]
L_8ed48a:
	mov_s r2,0x0
L_8ed48c:
	mov_s r3,0x801f6c
L_8ed492:
	mov r6,0x9
L_8ed496:
	b.d L_8d6478
L_8ed49a:
	mov r7,0x3
L_8ed49e:
	nop_s
