/* bi_manager__kind_switch @ 0x9289e4, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bi_manager.cpp
 * Зовут его: bi_ap_mon__bti_event
 * Зовёт сам: bi__decide_beacon_kind, bi_ap_mon_if__trigger, bi_manager__enter_dti, uc_sysassert
 */
	.section .text.bi_manager__kind_switch,"ax",@progbits
	.global bi_manager__kind_switch
bi_manager__kind_switch:
	.global L_9289e4
L_9289e4:
	st.a r13,[sp,-0x8]
L_9289e8:
	st blink,[sp, 0x4]
L_9289ec:
	bl.d L_9311a4
L_9289f0:
	mov r13,r0
L_9289f4:
	brhs r0,0x6,L_928a2c
L_9289f8:
	ld.as r1,[0x800ed4,r0]
L_928a00:
	j_s [r1]
L_928a02:
	mov_s r0,0x1
L_928a04:
	bl.d L_9304c8
L_928a08:
	mov r1,0x0
L_928a0c:
	ld blink,[sp, 0x4]
L_928a10:
	j.d [blink]
L_928a14:
	ld.ab r13,[sp,0x8]
L_928a18:
	bl.d L_926858
L_928a1c:
	mov r0,r13
L_928a20:
	ld blink,[sp, 0x4]
L_928a24:
	j.d [blink]
L_928a28:
	ld.ab r13,[sp,0x8]
	.global L_928a2c
L_928a2c:
	mov_s r0,blink
L_928a2e:
	mov_s r2,0x1002b80
L_928a34:
	mov r1,0x76
L_928a38:
	bl.d L_925548
L_928a3c:
	mov r3,0x2a
L_928a40:
	ld blink,[sp, 0x4]
L_928a44:
	j.d [blink]
L_928a48:
	ld.ab r13,[sp,0x8]
