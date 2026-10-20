/* find_main_sm__stop @ 0x8f1730, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm::stop()  unlocking radio 0x%x
 *   FIND_SM:: free dband info when stop
 * Зовут его: find_main_sm__stop_searching
 * Зовёт сам: RADIO_MGR__unlock, __ld_r14_to_r13_ret, __st_r14_to_r13, find_mngr__del_discovery_bcon, find_sm__stop_discovery, free_dband_info, fw_log__emit0, fw_log__emit1, llist__pop_front
 */
	.section .text.find_main_sm__stop,"ax",@progbits
	.global find_main_sm__stop
find_main_sm__stop:
	.global L_8f1730
L_8f1730:
	push_s blink
L_8f1732:
	bl.d L_8c02c4
L_8f1736:
	mov_s r1,0x2
L_8f1738:
	mov_s r13,r0
L_8f173a:
	mov_s r2,0x10146d8
L_8f1740:
	mov_s r0,0xc
L_8f1742:
	bl.d L_8edfcc
L_8f1746:
	ld_s r3,[r13,0x38]
L_8f1748:
	bl.d L_8e54d8
L_8f174c:
	ld_s r0,[r13,0x38]
L_8f174e:
	mov_s r0,0x0
L_8f1750:
	st_s r0,[r13,0x38]
L_8f1752:
	b_s L_8f176c
	.global L_8f1754
L_8f1754:
	mov_s r2,0x1014704
L_8f175a:
	mov_s r0,0xc
L_8f175c:
	bl.d L_8edfb0
L_8f1760:
	mov_s r1,0x1
L_8f1762:
	bl.d L_8de2d4
L_8f1766:
	mov_s r0,r14
L_8f1768:
	bl L_8ebb88
	.global L_8f176c
L_8f176c:
	add r14,r13,0x3c
L_8f1770:
	ld_s r0,[r14]
L_8f1772:
	sub.f r0,r0,0x0
L_8f1776:
	mov.ne r0,0x1
L_8f177a:
	extb.f 0x0,r0
L_8f177e:
	bne_s L_8f1754
L_8f1780:
	bl.d L_8c771c
L_8f1784:
	ld_s r0,[r13,0x34]
L_8f1786:
	bl.d L_8e2fc4
L_8f178a:
	ld_s r0,[r13,0x34]
L_8f178c:
	b L_8c0334
