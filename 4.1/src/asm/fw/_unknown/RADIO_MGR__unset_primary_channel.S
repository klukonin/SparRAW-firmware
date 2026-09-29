/* RADIO_MGR__unset_primary_channel @ 0x8e5568, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RADIO_MGR::unset_primary_channel
 * Зовут его: discovery__tsf_wa, l2mgr__disconnect_done, pcp_stop__flow
 * Зовёт сам: __ld_r13_ret, fw_log__emit0
 */
	.section .text.RADIO_MGR__unset_primary_channel,"ax",@progbits
	.global RADIO_MGR__unset_primary_channel
RADIO_MGR__unset_primary_channel:
	.global L_8e5568
L_8e5568:
	push_s blink
L_8e556a:
	push_s r13
L_8e556c:
	sub_s sp,sp,0x8
L_8e556e:
	mov_s r2,0x1015ba8
L_8e5574:
	mov_s r0,0x8
L_8e5576:
	bl.d L_8edfb0
L_8e557a:
	mov_s r1,0x2
L_8e557c:
	ld_s r0,[gp,-0x30]
L_8e557e:
	mov_s r2,0xffff
L_8e5584:
	ld_s r1,[r0]
L_8e5586:
	ld_s r13,[r1,0x4]
L_8e5588:
	mov_s r1,0x0
L_8e558a:
	mov_s r3,r1
L_8e558c:
	mov_s r4,r1
L_8e558e:
	mov_s r5,r1
L_8e5590:
	mov_s r6,r1
L_8e5592:
	jl_s.d [r13]
L_8e5594:
	mov_s r7,r1
L_8e5596:
	b.d L_8c033c
L_8e559a:
	add_s sp,sp,0x8
