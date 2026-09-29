/* obj_vt802458__ctor @ 0x8f5688, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: connection__init
 * Зовёт сам: basic_sm__bind_descriptor
 * Глобалы (через gp): 0x8001f0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt802458__ctor
obj_vt802458__ctor:
	.global L_8f5688
L_8f5688:
	mov_s r2,0x0
L_8f568a:
	mov_s r3,0x1
L_8f568c:
	st_s r2,[r0,0xc]
L_8f568e:
	st_s r2,[r0,0x8]
L_8f5690:
	st_s r2,[r0,0x10]
L_8f5692:
	st_s r2,[r0,0x14]
L_8f5694:
	st_s r2,[r0,0x18]
L_8f5696:
	st_s r2,[r0,0x1c]
L_8f5698:
	stw_s r2,[r0,0x28]
L_8f569a:
	stw_s r3,[r0,0x2a]
L_8f569c:
	st_s r2,[r0,0x2c]
L_8f569e:
	st_s r2,[r0,0x30]
L_8f56a0:
	st_s r1,[r0,0x20]
L_8f56a2:
	ld.as r1,[gp,0x1b]
L_8f56a6:
	brne_s r1,0,L_8f56ac
L_8f56a8:
	st.as r3,[gp,0x1b]
	.global L_8f56ac
L_8f56ac:
	mov_s r1,0x802458
L_8f56b2:
	b L_8d94e0
L_8f56b6:
	nop_s
