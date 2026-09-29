/* calib_lo_power__correction_alg @ 0x8c6714, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   class_calib_lo_power::correction_alg undefined lo power configuration state: %d
 *   calib_lo_power.cpp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_sysassert_fatal, get_g_80023d, get_g_80023e, get_g_80023f, set_g_8000fc, stub_ret_8ca168, stub_ret_8ca170
 */
	.section .text.calib_lo_power__correction_alg,"ax",@progbits
	.global calib_lo_power__correction_alg
calib_lo_power__correction_alg:
L_8c6714:
	sub_s sp,sp,0x4
L_8c6716:
	push_s blink
L_8c6718:
	bl L_8c02bc
L_8c671c:
	bl.d L_8ca178
L_8c6720:
	mov_s r14,r0
L_8c6722:
	bl.d L_8ca164
L_8c6726:
	mov_s r13,r0
L_8c6728:
	ld_s r3,[r14,0xc]
L_8c672a:
	mov_s r16,r0
L_8c672c:
	breq_s r3,0,L_8c6766
L_8c672e:
	breq r3,0x1,L_8c6758
L_8c6732:
	mov_s r2,0x1008cec
L_8c6738:
	mov_s r0,0x6
L_8c673a:
	bl.d L_8edfcc
L_8c673e:
	mov_s r1,0x0
L_8c6740:
	mov_s r0,blink
L_8c6742:
	mov_s r2,0x1008d3c
L_8c6748:
	mov_s r1,0x142c
L_8c674e:
	bl.d L_8c82c0
L_8c6752:
	mov_s r3,0x75
L_8c6754:
	mov_s r0,0x2
L_8c6756:
	b_s L_8c678c
	.global L_8c6758
L_8c6758:
	bl L_8ca17c
L_8c675c:
	mov_s r1,0x8004ac
L_8c6762:
	ldb_s r14,[r1,r0]
L_8c6764:
	b_s L_8c677a
	.global L_8c6766
L_8c6766:
	bl L_8ca17c
L_8c676a:
	mov.f r14,r0
L_8c676e:
	cmp.eq r13,0xe
L_8c6772:
	bne_s L_8c677a
L_8c6774:
	bl L_8ca168
L_8c6778:
	b_s L_8c677e
	.global L_8c677a
L_8c677a:
	bl L_8ca170
	.global L_8c677e
L_8c677e:
	mov_s r2,r0
L_8c6780:
	mov_s r0,r14
L_8c6782:
	mov_s r1,r13
L_8c6784:
	bl.d L_8d8f3c
L_8c6788:
	mov_s r3,r16
L_8c678a:
	mov_s r0,0x1
	.global L_8c678c
L_8c678c:
	mov_s r12,0x8
L_8c678e:
	.byte 0x9b,0x03
